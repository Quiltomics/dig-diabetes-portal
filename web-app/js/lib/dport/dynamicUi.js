var mpgSoftware = mpgSoftware || {};




mpgSoftware.dynamicUi = (function () {
    var loading = $('#rSpinner');
    var commonTable;
    var dyanamicUiVariables;

    var setDyanamicUiVariables = function(incomingDyanamicUiVariables){
        dyanamicUiVariables = incomingDyanamicUiVariables;
    };

    var getDyanamicUiVariables = function(){
        return dyanamicUiVariables;
    };

    var processRecordsFromMod = function (data){
        var returnObject = {rawData:[],
            uniqueGenes:[],
            uniqueTissues:[]};
        _.forEach(data,function(oneRec){
            if (!returnObject.uniqueTissues.includes(oneRec)){
                returnObject.uniqueTissues.push(oneRec);
            };
            returnObject.rawData.push(oneRec);
        });
        return returnObject;
    };


    var processRecordsUpdateContext = function (data){
        var returnObject = {geneName: undefined,
            chromosome : undefined,
            extentBegin : undefined,
            extentEnd : undefined,
        };
        if (( typeof data !== 'undefined')&&
            ( typeof data.geneInfo !== 'undefined')){
            returnObject.geneName = data.geneInfo.Gene_name;
            returnObject.chromosome = data.geneInfo.CHROM;
            returnObject.extentBegin = data.geneInfo.BEG;
            returnObject.extentEnd = data.geneInfo.END;
        }
        return returnObject;
    };


    var processRecordsFromEqtls = function (data){
        var returnObject = {rawData:[],
                            uniqueGenes:[],
                            uniqueTissues:[],
                            chromosome:undefined,
                            startPos:undefined,
                            endPos:undefined
        };
        _.forEach(data,function(oneRec){
            returnObject.rawData.push(oneRec);
            if ( typeof returnObject.startPos === 'undefined'){
                returnObject.startPos = oneRec.start_position;
            } else if (returnObject.startPos > oneRec.start_position){
                returnObject.startPos = oneRec.start_position;
            }
            if ( typeof returnObject.endPos === 'undefined'){
                returnObject.endPos = oneRec.end_position;
            } else if (returnObject.endPos < oneRec.end_position){
                returnObject.endPos = oneRec.end_position;
            }
            if ( typeof returnObject.chromosome === 'undefined'){
                returnObject.chromosome = oneRec.chromosome;
            }
            if (!returnObject.uniqueGenes.includes(oneRec.gene)){
                returnObject.uniqueGenes.push(oneRec.gene);
            };
            if (!returnObject.uniqueTissues.includes(oneRec.tissue)){
                returnObject.uniqueTissues.push(oneRec.tissue);
            };
        });
        return returnObject;
    };



    var processRecordsFromProximitySearch = function (data){
        var returnObject = {rawData:[],
            uniqueGenes:[],
            uniqueTissues:[]};
        if (( typeof data !== 'undefined') &&
            ( data !== null ) &&
            (data.is_error === false ) &&
            ( typeof data.listOfGenes !== 'undefined') ){
            if (data.listOfGenes.length === 0){
                alert(' No genes in the specified region')
            } else {
                _.forEach(data.listOfGenes,function(geneRec){
                    returnObject.rawData.push(geneRec);
                    if (!returnObject.uniqueGenes.includes(geneRec.name2)){
                        returnObject.uniqueGenes.push(geneRec.name2);
                    };
                });
            }
        }

        return returnObject;
    };


    var displayRangeContext = function(idForTheTargetDiv,objectContainingRetrievedRecords){
        $(idForTheTargetDiv).empty().append(Mustache.render($('#contextDescriptionSection')[0].innerHTML,
            objectContainingRetrievedRecords
        ));
        $("#configurableUiTabStorage").data("dataHolder").extentBegin = objectContainingRetrievedRecords.extentBegin;
        $("#configurableUiTabStorage").data("dataHolder").extentEnd = objectContainingRetrievedRecords.extentEnd;
        $("#configurableUiTabStorage").data("dataHolder").chromosome = objectContainingRetrievedRecords.chromosome;
        $("#configurableUiTabStorage").data("dataHolder").originalGeneName = objectContainingRetrievedRecords.geneName;
    }



    var displayRefinedModContext = function (idForTheTargetDiv,objectContainingRetrievedRecords){
        var selectorForIidForTheTargetDiv = '#' + idForTheTargetDiv;
        $(selectorForIidForTheTargetDiv).empty();
        _.forEach(_.sortBy(_.uniq(objectContainingRetrievedRecords.rawData)),function(onePhenotypeName) {
            $(selectorForIidForTheTargetDiv).append(onePhenotypeName.Term+'\n');
        });
    };

    var displayRefinedEqtlContext = function (idForTheTargetDiv,objectContainingRetrievedRecords){
        var selectorForIidForTheTargetDiv = '#' + idForTheTargetDiv;
        $(selectorForIidForTheTargetDiv).empty();
        _.forEach(objectContainingRetrievedRecords.uniqueTissues,function(oneTissue) {
            $(selectorForIidForTheTargetDiv).append(oneTissue+'\n');
        });
        if ( typeof objectContainingRetrievedRecords.startPos !== 'undefined'){
            $('span.dynamicUiGeneExtentBegin').html(''+objectContainingRetrievedRecords.startPos);
        }
        if ( typeof objectContainingRetrievedRecords.endPos !== 'undefined'){
            $('span.dynamicUiGeneExtentEnd').html(''+objectContainingRetrievedRecords.endPos);
        }
        if ( typeof objectContainingRetrievedRecords.chromosome !== 'undefined'){
            $('span.dynamicUiChromosome').html(''+objectContainingRetrievedRecords.chromosome);
        }
        $("#dynamicUiGeneHolder").empty().append(Mustache.render($('#dynamicGeneTable')[0].innerHTML,
            objectContainingRetrievedRecords
        ));
    };


    var displayRefinedGenesInARange = function (idForTheTargetDiv,objectContainingRetrievedRecords){
        var selectorForIidForTheTargetDiv = '#' + idForTheTargetDiv;
        $(selectorForIidForTheTargetDiv).empty();
        _.forEach(objectContainingRetrievedRecords.uniqueTissues,function(oneTissue) {
            $(selectorForIidForTheTargetDiv).append(oneTissue+'\n');
        });
        $("#dynamicUiGeneHolder").empty().append(Mustache.render($('#dynamicGeneTable')[0].innerHTML,
            objectContainingRetrievedRecords
        ));


    };





    var retrieveRefinedContext=function(inParms,additionalParameters){
        var promiseArray = [];
        var rememberInParmsGene = inParms.gene;
        var rememberChromosome = inParms.chromosome;
        var rememberExtentBegin = inParms.startPos;
        var rememberExtentEnd = inParms.endPos;

        var rememberProcessEachRecord = inParms.processEachRecord;
        var rememberRetrieveDataUrl = inParms.retrieveDataUrl;
        var rememberDisplayRefinedContextFunction =  inParms.displayRefinedContextFunction;
        var rememberPlaceToDisplayData = inParms.placeToDisplayData;
        var objectContainingRetrievedRecords = [];
        promiseArray.push(
            $.ajax({
                cache: false,
                type: "post",
                url: rememberRetrieveDataUrl,
                data: { gene: rememberInParmsGene,
                        geneName:rememberInParmsGene,
                        chromosome: rememberChromosome,
                        startPos: rememberExtentBegin,
                        endPos: rememberExtentEnd },
                async: true
            }).done(function (data, textStatus, jqXHR) {

                objectContainingRetrievedRecords = rememberProcessEachRecord( data );

            }).fail(function (jqXHR, textStatus, errorThrown) {
                loading.hide();
                core.errorReporter(jqXHR, errorThrown)
            })
        );
        $.when.apply($, promiseArray).then(function(allCalls) {

            rememberDisplayRefinedContextFunction( rememberPlaceToDisplayData, objectContainingRetrievedRecords );

        }, function(e) {
            console.log("Ajax call failed");
        });

    };




    var modifyScreenFields = function (data, additionalParameters) {
        var updateDynamicUiInResponseToButtonClick = function(item, additionalParameters) {
            retrieveRefinedContext(item, additionalParameters);
        };
        $('#'+additionalParameters.generalizedInputId).typeahead({
            source: function (query, process) {
                $.get(additionalParameters.generalizedTypeaheadUrl, {query: query}, function (data) {
                    process(data, additionalParameters);
                })
            },
            afterSelect: function(selection) {
                //alert('not sure if we want a default behavior here?');;
            }
        });


        // manually set the range
        $('#'+additionalParameters.generalizedGoButtonId).on('click', function () {
            var somethingSymbol = $('#'+additionalParameters.generalizedInputId).val();
            somethingSymbol = somethingSymbol.replace(/\//g,"_"); // forward slash crashes app (even though it is the LZ standard variant format
            if (somethingSymbol) {
                updateDynamicUiInResponseToButtonClick({   gene:somethingSymbol,
                        processEachRecord:processRecordsUpdateContext,
                        retrieveDataUrl:additionalParameters.geneInfoAjaxUrl,
                        displayRefinedContextFunction:displayRangeContext,
                        placeToDisplayData:'#contextDescription'
                    },
                    additionalParameters)
            }
        });

        // assign the correct response to the MOD go button
        $('#'+additionalParameters.modAnnotationButtonId).on('click', function () {
            var somethingSymbol = $("#configurableUiTabStorage").data("dataHolder").originalGeneName;
            if (somethingSymbol) {
                updateDynamicUiInResponseToButtonClick({   gene:somethingSymbol,
                        processEachRecord:processRecordsFromMod,
                        retrieveDataUrl:additionalParameters.retrieveModDataUrl,
                        displayRefinedContextFunction:displayRefinedModContext,
                        placeToDisplayData:additionalParameters.phenoHolder
                    },
                    additionalParameters)
            }
        });

        // assign the correct response to the eQTL go button
        $('#'+additionalParameters.eQTLGoButtonId).on('click', function () {
            var somethingSymbol = $("#configurableUiTabStorage").data("dataHolder").originalGeneName;
            if (somethingSymbol) {
                updateDynamicUiInResponseToButtonClick({   gene:somethingSymbol,
                        processEachRecord:processRecordsFromEqtls,
                        retrieveDataUrl:additionalParameters.retrieveEqtlDataUrl,
                        displayRefinedContextFunction:displayRefinedEqtlContext,
                        placeToDisplayData:additionalParameters.dynamicUiTissueHolder
                    },
                    additionalParameters)
            }
        });


        // assign the correct response to the eQTL go button
        $('#'+additionalParameters.genesWithinRangeButtonId).on('click', function () {
            var chromosome  = $("#configurableUiTabStorage").data("dataHolder").chromosome;
            var extentBegin  = $("#configurableUiTabStorage").data("dataHolder").extentBegin;
            var extentEnd  = $("#configurableUiTabStorage").data("dataHolder").extentEnd;
            if  ( ( typeof chromosome !== 'undefined') &&
                ( typeof extentBegin !== 'undefined') &&
                ( typeof extentEnd !== 'undefined') ) {
                updateDynamicUiInResponseToButtonClick({
                            processEachRecord:processRecordsFromProximitySearch,
                            retrieveDataUrl:additionalParameters.retrieveListOfGenesInARangeUrl,
                            displayRefinedContextFunction:displayRefinedGenesInARange,
                            chromosome:chromosome ,
                            startPos:extentBegin ,
                            endPos:extentEnd,
                            placeToDisplayData:additionalParameters.dynamicUiGeneHolder },
                    additionalParameters)
            }
        });

        var chrom=(additionalParameters.geneChromosome.indexOf('chr')>-1)?additionalParameters.geneChromosome.substr(3):additionalParameters.geneChromosome;
        $("#configurableUiTabStorage").data("dataHolder",{
            extentBegin:additionalParameters.geneExtentBegin,
            extentEnd:additionalParameters.geneExtentEnd,
            chromosome:chrom,
            originalGeneName:additionalParameters.geneName,
            geneNameArray:[]});

        $('#contextDescription').empty().append(Mustache.render($('#contextDescriptionSection')[0].innerHTML,
            $("#configurableUiTabStorage").data("dataHolder")
        ));

    };
    var adjustExtentHolders = function(domStorage,storageField,spanClass,basesToShift){
        var extentBegin = parseInt( domStorage[storageField] );
        extentBegin += basesToShift;
        domStorage[storageField] = extentBegin;
        $(spanClass).html(""+extentBegin);
    };

    var adjustLowerExtent = function(basesToShift){
        adjustExtentHolders($("#configurableUiTabStorage").data("dataHolder"),"extentBegin","span.dynamicUiGeneExtentBegin",basesToShift);
    };

    var adjustUpperExtent = function(basesToShift){
        adjustExtentHolders($("#configurableUiTabStorage").data("dataHolder"),"extentEnd","span.dynamicUiGeneExtentEnd",basesToShift);
    };



// public routines are declared below
    return {
        modifyScreenFields:modifyScreenFields,
        adjustLowerExtent:adjustLowerExtent,
        adjustUpperExtent:adjustUpperExtent
    }

}());


