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


    /***
     *
     * @param data
     * @returns {{geneName: undefined, chromosome: undefined, extentBegin: undefined, extentEnd: undefined}}
     */
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
    var displayRangeContext = function(idForTheTargetDiv,objectContainingRetrievedRecords){
        $(idForTheTargetDiv).empty().append(Mustache.render($('#contextDescriptionSection')[0].innerHTML,
            objectContainingRetrievedRecords
        ));
        $("#configurableUiTabStorage").data("dataHolder").extentBegin = objectContainingRetrievedRecords.extentBegin;
        $("#configurableUiTabStorage").data("dataHolder").extentEnd = objectContainingRetrievedRecords.extentEnd;
        $("#configurableUiTabStorage").data("dataHolder").chromosome = objectContainingRetrievedRecords.chromosome;
        $("#configurableUiTabStorage").data("dataHolder").originalGeneName = objectContainingRetrievedRecords.geneName;
    }


    /***
     * Mod annotation search
     * @param idForTheTargetDiv
     * @param objectContainingRetrievedRecords
     */
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
    var displayRefinedModContext = function (idForTheTargetDiv,objectContainingRetrievedRecords){
        var selectorForIidForTheTargetDiv = idForTheTargetDiv;
        $(selectorForIidForTheTargetDiv).empty();
        _.forEach(_.sortBy(_.uniq(objectContainingRetrievedRecords.rawData)),function(onePhenotypeName) {
            $(selectorForIidForTheTargetDiv).append('<div class="resultElementPerLine">'+onePhenotypeName.Term+'</div>');
        });
    };




    /***
     * gene eQTL search
     * @param data
     * @returns {{rawData: Array, uniqueGenes: Array, uniqueTissues: Array, chromosome: undefined, startPos: undefined, endPos: undefined}}
     */
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
        // we need to add tissues for each gene
        if (( typeof returnObject.uniqueGenes !== 'undefined')&&( returnObject.uniqueGenes.length>1 )){
            console.log('did not expect multiple genes');
        } else {
            var genRecordIndex = _.findIndex($("#configurableUiTabStorage").data("dataHolder").geneNameArray,
                {name:returnObject.uniqueGenes[0]});
            $("#configurableUiTabStorage").data("dataHolder").geneNameArray[genRecordIndex]['tissues'] = returnObject.uniqueTissues;
        }
        return returnObject;
    };
    var displayRefinedEqtlContext = function (idForTheTargetDiv,objectContainingRetrievedRecords){
        var returnObject = {rawData:[],
            eqtlTissuesExist:[1],
            uniqueGenes:[],
            uniqueEqtlGenes:[],
            genePositions:[],
            uniqueTissues:[],
            geneTissueEqtls:[],
            genesPositionsExist:function(){
                return (this.genePositions.length>0)?[1]:[];
            },
            genesExist:function(){
                return (this.uniqueGenes.length>0)?[1]:[];
            }
        };
        // pull everything out of the dom variable, not the passed in parameter
        _.forEach($("#configurableUiTabStorage").data("dataHolder").geneNameArray,function(eachGene){
            returnObject.uniqueGenes.push({name:eachGene.name});

            var recordToDisplay = {tissues:[]};
            _.forEach(eachGene.tissues,function(eachTissue){
                recordToDisplay.tissues.push({tissueName:eachTissue})
            });;
            returnObject.uniqueEqtlGenes.push(recordToDisplay);
        });
        $("#dynamicGeneHolder div.dynamicUiHolder").empty().append(Mustache.render($('#dynamicGeneTable')[0].innerHTML,
            returnObject
        ));
    };

    /***
     * Gene proximity search
     * @param data
     * @returns {{rawData: Array, uniqueGenes: Array, uniqueTissues: Array}}
     */
    var processRecordsFromProximitySearch = function (data){
        var returnObject = {rawData:[],
            uniqueGenes:[],
            genePositions:[],
            uniqueTissues:[],
            genesPositionsExist:function(){
                return (this.genePositions.length>0)?[1]:[];
            },
            genesExist:function(){
                return (this.uniqueGenes.length>0)?[1]:[];
            }
        };
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
                        returnObject.uniqueGenes.push({name:geneRec.name2});
                        returnObject.genePositions.push({name:geneRec.chromosome +":"+geneRec.addrStart +"-"+geneRec.addrEnd});
                    };
                });
            }
        }
        // we have a list of all the genes in the range.  Let's remember that information.
        $("#configurableUiTabStorage").data("dataHolder").geneNameArray =  returnObject.uniqueGenes;
        return returnObject;
    };
    var displayRefinedGenesInARange = function (idForTheTargetDiv,objectContainingRetrievedRecords){
        var selectorForIidForTheTargetDiv = idForTheTargetDiv;
        $(selectorForIidForTheTargetDiv).empty();
        // _.forEach(objectContainingRetrievedRecords.uniqueTissues,function(oneTissue) {
        //     $(selectorForIidForTheTargetDiv).append('<div class="resultElementPerLine">'+oneTissue+'</div>');
        // });
        $("#dynamicGeneHolder div.dynamicUiHolder").empty().append(Mustache.render($('#dynamicGeneTable')[0].innerHTML,
            objectContainingRetrievedRecords
        ));
    };



    var processRecordsFromVariantQtlSearch = function (data) {
        var returnObject = {rawData:[],
            uniqueGenes:[],
            uniquePhenotypes:[],
            uniqueVarIds:[]
        };
        if ( ( typeof data !== 'undefined') &&
                ( typeof data.data !== 'undefined') &&
                ( typeof data.header !== 'undefined') &&
                ( data.header.length > 0 ) ) {
            var varIdIndex =  _.indexOf(data.header,'VAR_ID');
            var geneIndex =  _.indexOf(data.header,'GENE');
            var phenotypeIndex =  _.indexOf(data.header,'PHENOTYPE');
            var numberOfElements =  data.data[0].length;
            for ( var variant = 0; variant < numberOfElements; variant++ ){
                var varId = data.data[varIdIndex][variant];
                var gene = data.data[geneIndex][variant];
                var phenotype = data.data[phenotypeIndex][variant];
                if (!returnObject.uniqueGenes.includes(gene)){
                    returnObject.uniqueGenes.push(gene);
                };
                if (!returnObject.uniquePhenotypes.includes(phenotype)){
                    returnObject.uniquePhenotypes.push(phenotype);
                };
                if (!returnObject.uniqueVarIds.includes(varId)){
                    returnObject.uniqueVarIds.push(varId);
                };
                returnObject.rawData.push({varId:varId,gene:gene,phenotype:phenotype});
            }
        } else {
            alert('API call return to unexpected result. Is the KB fully functional?');
        }
        returnObject.uniqueGenes = returnObject.uniqueGenes.sort();
        returnObject.uniquePhenotypes = returnObject.uniquePhenotypes.sort();
        returnObject.uniqueVarIds = returnObject.uniqueVarIds.sort();
        return returnObject;
    };
    var displayVariantRecordsFromVariantQtlSearch = function  (idForTheTargetDiv,objectContainingRetrievedRecords) {
        $(idForTheTargetDiv).empty();
        _.forEach(objectContainingRetrievedRecords.uniqueVarIds,function(oneTissue) {
            $(idForTheTargetDiv).append('<div class="resultElementPerLine">'+oneTissue+'</div>');
        });
    };
    var displayPhenotypeRecordsFromVariantQtlSearch = function  (idForTheTargetDiv,objectContainingRetrievedRecords) {
        $(idForTheTargetDiv).empty();
        _.forEach(objectContainingRetrievedRecords.uniquePhenotypes,function(onePhenotype) {
            $(idForTheTargetDiv).append('<div class="resultElementPerLine">'+onePhenotype+'</div>');
        });

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
        if ( typeof inParms.loopOverGenes === 'undefined') {
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

        } else {
            _.forEach(inParms.loopOverGenes,function(eachGene){
                promiseArray.push(
                    $.ajax({
                        cache: false,
                        type: "post",
                        url: rememberRetrieveDataUrl,
                        data: { gene: eachGene.name },
                        async: true
                    }).done(function (data, textStatus, jqXHR) {

                        objectContainingRetrievedRecords = rememberProcessEachRecord( data );

                    }).fail(function (jqXHR, textStatus, errorThrown) {
                        loading.hide();
                        core.errorReporter(jqXHR, errorThrown)
                    })
                );
            });

        }
         $.when.apply($, promiseArray).then(function(allCalls) {

            rememberDisplayRefinedContextFunction( rememberPlaceToDisplayData, objectContainingRetrievedRecords );

        }, function(e) {
            console.log("Ajax call failed");
        });

    };




    var installDirectorButtonsOnTabs =  function ( additionalParameters) {
        /***
         * gene tab
         * @type {{directorButtons: *[]}}
         */
        var objectDescribingDirectorButtons = {
            directorButtons: [{buttonId: 'genesWithinRangeButtonId', buttonName: 'proximity', description: 'present all genes overlapping  the specified region'},
                {buttonId: 'eQTL-dynamic-gene-go', buttonName: 'eQTL', description: 'present all genes overlapping  the specified region for which some eQTL relationship exists'}]
        };
        $("#dynamicGeneHolder div.directorButtonHolder").empty().append(Mustache.render($('#templateForDirectorButtonsOnATab')[0].innerHTML,
            objectDescribingDirectorButtons
        ));

        /***
         * variant tab
         * @type {{directorButtons: {buttonId: string, buttonName: string, description: string}[]}}
         */
        objectDescribingDirectorButtons = {
            directorButtons: [{buttonId: 'getVariantsButtonId', buttonName: 'QTL', description: 'find all variants in the above range with QTL relationship with some phenotype'}]
        };
        $("#dynamicVariantHolder div.directorButtonHolder").empty().append(Mustache.render($('#templateForDirectorButtonsOnATab')[0].innerHTML,
            objectDescribingDirectorButtons
        ));

        /***
         * tissue tab
         * @type {{directorButtons: {buttonId: string, buttonName: string, description: string}[]}}
         */
        objectDescribingDirectorButtons = {
            directorButtons: [{buttonId: 'getTissuesFromEqtlButtonId', buttonName: 'eQTL', description: 'find all tissues for which eQTLs exist foraging in the specified range'}]
        };
        $("#dynamicTissueHolder div.directorButtonHolder").empty().append(Mustache.render($('#templateForDirectorButtonsOnATab')[0].innerHTML,
            objectDescribingDirectorButtons
        ));

        /***
         * phenotype tab
         * @type {{directorButtons: *[]}}
         */
        objectDescribingDirectorButtons = {
            directorButtons: [{buttonId: 'getPhenotypesFromQtlButtonId', buttonName: 'QTL', description: 'find all phenotypes for which QTLs exist in the above'},
                {buttonId: 'modAnnotationButtonId', buttonName: 'MOD', description: 'list mouse knockout annotations  for all genes overlapping the specified region'}]
        };
        $("#dynamicPhenotypeHolder div.directorButtonHolder").empty().append(Mustache.render($('#templateForDirectorButtonsOnATab')[0].innerHTML,
            objectDescribingDirectorButtons
        ));

    };







    var modifyScreenFields = function (data, additionalParameters) {

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
                retrieveRefinedContext({   gene:somethingSymbol,
                        processEachRecord:processRecordsUpdateContext,
                        retrieveDataUrl:additionalParameters.geneInfoAjaxUrl,
                        displayRefinedContextFunction:displayRangeContext,
                        placeToDisplayData:'#contextDescription'
                    },
                    additionalParameters)
            }
        });

        // pull back mouse annotations
        $('#modAnnotationButtonId').on('click', function () {
            var somethingSymbol = $("#configurableUiTabStorage").data("dataHolder").originalGeneName;
            if (somethingSymbol) {
                retrieveRefinedContext({   gene:somethingSymbol,
                        processEachRecord:processRecordsFromMod,
                        retrieveDataUrl:additionalParameters.retrieveModDataUrl,
                        displayRefinedContextFunction:displayRefinedModContext,
                        placeToDisplayData: '#dynamicPhenotypeHolder div.dynamicUiHolder'
                    },
                    additionalParameters)
            }
        });

        // perform an eQTL based lookup
        $('#eQTL-dynamic-gene-go').on('click', function () {
            var somethingSymbol = $("#configurableUiTabStorage").data("dataHolder").geneNameArray;
            if (!somethingSymbol){
                somethingSymbol = [$("#configurableUiTabStorage").data("dataHolder").originalGeneName];
            }
            if (somethingSymbol) {
                retrieveRefinedContext({   loopOverGenes:somethingSymbol,
                        processEachRecord:processRecordsFromEqtls,
                        retrieveDataUrl:additionalParameters.retrieveEqtlDataUrl,
                        displayRefinedContextFunction:displayRefinedEqtlContext,
                        placeToDisplayData: '#dynamicTissueHolder div.dynamicUiHolder'
                    },
                    additionalParameters)
            }
        });


        // assign the correct response to the proximity range go button
        $('#genesWithinRangeButtonId').on('click', function () {
            var chromosome  = $("#configurableUiTabStorage").data("dataHolder").chromosome;
            var extentBegin  = $("#configurableUiTabStorage").data("dataHolder").extentBegin;
            var extentEnd  = $("#configurableUiTabStorage").data("dataHolder").extentEnd;
            if  ( ( typeof chromosome !== 'undefined') &&
                ( typeof extentBegin !== 'undefined') &&
                ( typeof extentEnd !== 'undefined') ) {
                retrieveRefinedContext({
                            processEachRecord:processRecordsFromProximitySearch,
                            retrieveDataUrl:additionalParameters.retrieveListOfGenesInARangeUrl,
                            displayRefinedContextFunction:displayRefinedGenesInARange,
                            chromosome:chromosome ,
                            startPos:extentBegin ,
                            endPos:extentEnd,
                            placeToDisplayData: '#dynamicGeneHolder div.dynamicUiHolder'  },
                    additionalParameters)
            }
        });


        $('#getVariantsButtonId').on('click', function () {
            var chromosome  = $("#configurableUiTabStorage").data("dataHolder").chromosome;
            var extentBegin  = $("#configurableUiTabStorage").data("dataHolder").extentBegin;
            var extentEnd  = $("#configurableUiTabStorage").data("dataHolder").extentEnd;
            if  ( ( typeof chromosome !== 'undefined') &&
                ( typeof extentBegin !== 'undefined') &&
                ( typeof extentEnd !== 'undefined') ) {
                retrieveRefinedContext({
                        processEachRecord:processRecordsFromVariantQtlSearch,
                        retrieveDataUrl:additionalParameters.retrieveVariantsWithQtlRelationshipsUrl,
                        displayRefinedContextFunction:displayVariantRecordsFromVariantQtlSearch,
                        chromosome:chromosome ,
                        startPos:extentBegin ,
                        endPos:extentEnd,
                        placeToDisplayData: '#dynamicVariantHolder div.dynamicUiHolder'  },
                    additionalParameters)
            }
        });


        $('#getTissuesFromEqtlButtonId').on('click', function () {
            var somethingSymbol = $("#configurableUiTabStorage").data("dataHolder").originalGeneName;
            if (somethingSymbol) {
                retrieveRefinedContext({
                        gene: somethingSymbol,
                        processEachRecord: processRecordsFromEqtls,
                        retrieveDataUrl: additionalParameters.retrieveEqtlDataUrl,
                        displayRefinedContextFunction: displayRefinedEqtlContext,
                        placeToDisplayData: '#dynamicTissueHolder div.dynamicUiHolder'
                    },
                    additionalParameters)
            }
        });


        $('#getPhenotypesFromQtlButtonId').on('click', function () {
            var chromosome  = $("#configurableUiTabStorage").data("dataHolder").chromosome;
            var extentBegin  = $("#configurableUiTabStorage").data("dataHolder").extentBegin;
            var extentEnd  = $("#configurableUiTabStorage").data("dataHolder").extentEnd;
            if  ( ( typeof chromosome !== 'undefined') &&
                ( typeof extentBegin !== 'undefined') &&
                ( typeof extentEnd !== 'undefined') ) {
                retrieveRefinedContext({
                        processEachRecord:processRecordsFromVariantQtlSearch,
                        retrieveDataUrl:additionalParameters.retrieveVariantsWithQtlRelationshipsUrl,
                        displayRefinedContextFunction:displayPhenotypeRecordsFromVariantQtlSearch,
                        chromosome:chromosome ,
                        startPos:extentBegin ,
                        endPos:extentEnd,
                        placeToDisplayData: '#dynamicPhenotypeHolder div.dynamicUiHolder'  },
                    additionalParameters)
            }
        });





        /***
         * Non tab-based placement
         * @type {string}
         */
        var chrom=(additionalParameters.geneChromosome.indexOf('chr')>-1)?additionalParameters.geneChromosome.substr(3):additionalParameters.geneChromosome;
        $("#configurableUiTabStorage").data("dataHolder",{
            extentBegin:additionalParameters.geneExtentBegin,
            extentEnd:additionalParameters.geneExtentEnd,
            chromosome:chrom,
            originalGeneName:additionalParameters.geneName,
            geneNameArray:[],
            contextDescr:{
                chromosome: chrom,
                extentBegin:additionalParameters.geneExtentBegin,
                extentEnd:additionalParameters.geneExtentEnd,
                moreContext:[]
            }});

        $('#contextDescription').empty().append(Mustache.render($('#contextDescriptionSection')[0].innerHTML,
            $("#configurableUiTabStorage").data("dataHolder").contextDescr
        ));

    };



    var adjustExtentHolders = function(domStorage,storageField,spanClass,basesToShift){
        var extentBegin = parseInt( domStorage[storageField] );
        if ((extentBegin+basesToShift)>0){
            extentBegin += basesToShift;
        } else {
            extentBegin = 0;
        }
        domStorage[storageField] = extentBegin;
        $(spanClass).html(""+extentBegin);
    };

    var adjustLowerExtent = function(basesToShift){
        if (basesToShift>0){
            if ( ( parseInt($("#configurableUiTabStorage").data("dataHolder").extentBegin)+basesToShift ) > //
                 ( parseInt($("#configurableUiTabStorage").data("dataHolder").extentEnd ) ) ){
                return;
            }
        }
        adjustExtentHolders($("#configurableUiTabStorage").data("dataHolder"),"extentBegin","span.dynamicUiGeneExtentBegin",basesToShift);
    };

    var adjustUpperExtent = function(basesToShift){
        if (basesToShift<0){
            if ( ( parseInt($("#configurableUiTabStorage").data("dataHolder").extentEnd )+basesToShift ) < //
                 ( parseInt($("#configurableUiTabStorage").data("dataHolder").extentBegin ) ) ){
                return;
            }
        }
        adjustExtentHolders($("#configurableUiTabStorage").data("dataHolder"),"extentEnd","span.dynamicUiGeneExtentEnd",basesToShift);
    };



// public routines are declared below
    return {
        installDirectorButtonsOnTabs:installDirectorButtonsOnTabs,
        modifyScreenFields:modifyScreenFields,
        adjustLowerExtent:adjustLowerExtent,
        adjustUpperExtent:adjustUpperExtent
    }

}());


