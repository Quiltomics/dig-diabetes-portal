// Some DOM assignments that we can encapsulate inside an immediate execution function.
(function () {
    jQuery.fn.dataTableExt.oSort['stringAnchor-asc'] = function (a, b) {
        var x = UTILS.extractAnchorTextAsString(a);
        var y = UTILS.extractAnchorTextAsString(b);
        return (x.localeCompare(y));
    };
    
    jQuery.fn.dataTableExt.oSort['stringAnchor-desc'] = function (a, b) {
        var x = UTILS.extractAnchorTextAsString(a);
        var y = UTILS.extractAnchorTextAsString(b);
        return (y.localeCompare(x));
    };
    
    jQuery.fn.dataTableExt.oSort['headerAnchor-asc'] = function (a, b) {
        var str1 = UTILS.extractHeaderTextWJqueryAsString(a);
        var str2 = UTILS.extractHeaderTextWJqueryAsString(b);
        if (!str1) {
            str1 = '';
        }
        if (!str2) {
            str2 = '';
        }
        return str1.localeCompare(str2);
    };
    
    jQuery.fn.dataTableExt.oSort['headerAnchor-desc'] = function (a, b) {
        var str1 = UTILS.extractHeaderTextWJqueryAsString(b);
        var str2 = UTILS.extractHeaderTextWJqueryAsString(a);
        if (!str1) {
            str1 = '';
        }
        if (!str2) {
            str2 = '';
        }
        return str2.localeCompare(str1);
    };

}());
var variantProcessing = (function () {

    /***
     * private functions
     */

    var deconvoluteVariantInfo = function(vRec) {
        if ((typeof vRec !== 'undefined') &&
            (typeof vRec.results !== 'undefined')  &&
            (typeof vRec.results[0] !== 'undefined')  &&
            (typeof vRec.results[0]["pVals"] !== 'undefined')  &&
            (vRec.results[0]["pVals"].length > 0) ) {
            var data = vRec.results[0]["pVals"];
            // first let's go through and process the metadata. For example we can make a data structure  with one
            // row for each phenotype (eventually these will correspond to the rows of the table).  as well, figure out

            var phenoStruct = [];
            for (var i = 0; i < data.length; i++) {
                var key = data [i].level;
                var splitKey = key.split("^");
                if (splitKey.length > 5) {
                    // P value handling
                    if (splitKey[1] !== 'NONE') {
                        var phenotypeMap = {'property': splitKey[0],
                            'phenotype': splitKey[1],
                            'translatedName': splitKey[6],
                            'translatedSGName': splitKey[5],
                            'meaning': splitKey[2],
                            'samplegroup': splitKey[3],
                            'pValue': data [i].count};
                        phenoStruct.push(phenotypeMap);
                    }

                    // maf value handling
                    if (splitKey[1] === 'NONE') {
                        var phenotypeMap = {'property': splitKey[0],
                            'phenotype': splitKey[1],
                            'meaning': splitKey[2],
                            'samplegroup': splitKey[3],
                            'translatedSGName': splitKey[5],
                            'pValue': data [i].count};
                        phenoStruct.push(phenotypeMap);
                    }
                }
            }
        }
        return phenoStruct;
    };


    /***
     *  Receive an array of objects as input.  Some of those objects will share common fields, notably 'phenotype',
     *  'meaning', and 'samplegroup'.  Phenotype implies that the objects should be grouped together in the eventual table, either on
     *  the same line or adjacent lines.  Meaning we use instead of property name to organize columns in the table (since properties
     *  may differ, but meaning is more consistent).  Sample group we use to put together properties that are not dependent on phenotype
     *  such as Minor Allele Frequency.  By the end of this function we build a structure which can be used to build our on-screen
     *  table in a fairly straightforward way.
     *
     * @param arrayOfFields
     * @returns {{}}
     */
    buildIntoRows = function(arrayOfFields) {
        var combinedStructure = {};
        if ((typeof arrayOfFields !== 'undefined') &&
            (arrayOfFields.length > 0)) {

            var columnList = _.chain(arrayOfFields).map('meaning').uniq().value();
            columnList.push('samplegroup');

            // temp structure we can use to collect things--pulls out all the phenotypes
            // except for "NONE" and groups all of the field items by phenotype, excluding fields
            // where pValue == (null or '')
            var collectingObject = _.chain(arrayOfFields).reject(['phenotype', 'NONE'])
                                                         .reject({pValue: null}).reject({pValue: ''})
                                                         .groupBy('phenotype').value();

            var newDataSetSpecificObject = _.chain(arrayOfFields).filter({phenotype: 'NONE'}).groupBy('samplegroup').value();

            // then, for each phenotype, grab all of the common dataset properties
            _.forEach(collectingObject, function(arrayOfProperties, phenotype) {
                var datasetsForPhenotype = _.chain(arrayOfProperties).map('samplegroup').uniq().value();
                _.forEach(datasetsForPhenotype, function(dataset) {
                    if( newDataSetSpecificObject[dataset] ) {
                        collectingObject[phenotype] = collectingObject[phenotype].concat((newDataSetSpecificObject[dataset]));
                    }
                });
            });

            // we should have everything we need to make the structure from which the table can be derived
            combinedStructure["columnList"] = columnList;
            combinedStructure["phenotypeRows"] = {};
            _.forEach(collectingObject, function(fieldsPerPhenotype, phenotypeName) {
                if (fieldsPerPhenotype.length>0){
                    // for each phenotype, group all of the properties by samplegroup
                    var groupedBySampleGroup = _.chain(fieldsPerPhenotype).groupBy('samplegroup').value();

                    combinedStructure["phenotypeRows"][phenotypeName] = [];
                    _.forEach(groupedBySampleGroup, function(properties) {
                        // for every set of properties for a given sample group, merge all of the properties
                        var fieldAccumulator = _.reduce(properties, function(finalObject, thisProperty) {
                            finalObject[thisProperty.meaning] = thisProperty.pValue;
                            // do this so we ignore fields we don't need
                            var commonProps = _.pick(thisProperty, ['samplegroup', 'translatedSGName', 'translatedName']);
                            _.merge(finalObject, commonProps);
                            return finalObject;
                        }, {});

                        combinedStructure["phenotypeRows"][phenotypeName].push(fieldAccumulator);
                    });
                }
            });
        }
        return combinedStructure;

    };

    addTraitsPerVariantTable = function ( vRecO, openPhenotypes, traitsPerVariantTable,traitRootUrl,existingRowCount ) {
        var retVal = [];
        if (!vRecO) {   // error condition
            return;
        }

        var vRec = deconvoluteVariantInfo(vRecO);
        var structureForBuildingTable = buildIntoRows (vRec) ;
        var rowCounter = existingRowCount;
        for (var phenotypeName in structureForBuildingTable["phenotypeRows"]) {
            if ((structureForBuildingTable["phenotypeRows"].hasOwnProperty(phenotypeName))&&
                (phenotypeName!=="NONE")){

                var rowsPerPhenotype =  structureForBuildingTable["phenotypeRows"] [phenotypeName];
                var parentSG = "";
                for ( var i = 0 ; i < rowsPerPhenotype.length ; i++  ){
                    var row = rowsPerPhenotype[i];
                    var convertedPreProcSampleGroup = row['samplegroup'];
                    if (convertedPreProcSampleGroup.indexOf(':')>-1){
                        var cohortStringEnd =  convertedPreProcSampleGroup.indexOf(':');
                        parentSG = convertedPreProcSampleGroup.substr(0,cohortStringEnd);
                    }
                }
                // find index row
                var sortedByPVal = rowsPerPhenotype.sort(function(a,b){return a.P_VALUE-b.P_VALUE});
                var indexRow = 0;
                for ( var i = 0 ; i < rowsPerPhenotype.length ; i++  ){
                    if (rowsPerPhenotype[i].samplegroup === sortedByPVal[0].samplegroup){
                        indexRow = i;
                    }
                }
                for ( var i = 0 ; i < rowsPerPhenotype.length ; i++  ){
                    var row = rowsPerPhenotype[i];
                    retVal = [];

                    // some shared variables
                    var convertedTrait= row.translatedName;
                    var convertedSampleGroup= row.translatedSGName;
                    var dealingWithIndexRow = (i===indexRow);
                    var oddsRatioValue = Number.NaN;
                    var betaValue = Number.NaN;
                    var pValue = Number.NaN;
                    var mafValue = Number.NaN;
                    var rescueArrow = 0;

                    //
                    // pull numeric data out of our structure. Be prepared for any values to be missing
                    //
                    if (( typeof row["P_VALUE"] !== 'undefined')&&(row["P_VALUE"]!== '')&&(row["P_VALUE"]!== null)) {
                        pValue = parseFloat(row["P_VALUE"]);
                    }

                    if (( typeof row["ODDS_RATIO"] !== 'undefined')&&(row["ODDS_RATIO"]!== '')&&(row["ODDS_RATIO"]!== null)) {
                        oddsRatioValue = parseFloat(row["ODDS_RATIO"]);
                    }

                    if (( typeof row["BETA"] !== 'undefined')&&(row["BETA"]!== '')&&(row["BETA"]!== null)) {
                        betaValue = parseFloat(row["BETA"]);
                    }

                    if (( typeof row["MAF"] !== 'undefined')&&(row["MAF"]!== '')&&(row["MAF"]!== null)) {
                        mafValue = parseFloat(row["MAF"]);
                    }

                    // direction of effect is a little tricky.  Take it from the odds ratio if we have an odds ratio
                     if (!isNaN(oddsRatioValue)) {
                        if (oddsRatioValue>1){
                            rescueArrow = 1;
                        }else if (oddsRatioValue<1){
                            rescueArrow = -1;
                        }
                    }
                    // No odds ratio?  Take direction of effect from the beta if we have a beta
                    if ((rescueArrow===0)&&(!isNaN(betaValue))) {
                        if (betaValue>0){
                            rescueArrow = 1;
                        }else if (betaValue<0){
                            rescueArrow = -1;
                        }
                    }
                    // No odds ratio and no beta?  Maybe we have a direction that is independently specified.  That works too.
                    if ((rescueArrow===0)&&(( typeof row["DIR"] !== 'undefined')&&(row["DIR"]!== '')&&(row["DIR"]!== null) ) ){
                        if ( row["DIR"] === 1 ) {
                            rescueArrow = 1;
                        }
                        else if ( row["DIR"] === -1 ) {
                            rescueArrow = -1;
                        }
                    }

                    // field 1: data set
                    var openPhenotypeMarker = "";
                    var additionalClassNames = "";
                   // if (openPhenotypes.indexOf())
                    if (dealingWithIndexRow) {
                        additionalClassNames = "indexRow";
                        if (openPhenotypes.indexOf(phenotypeName)>-1){
                            additionalClassNames += " openPhenotype";
                        } else if (convertedSampleGroup === parentSG){
                            additionalClassNames += " openPhenotype";
                        }
                    } else {
                        if (openPhenotypes.indexOf(phenotypeName)>-1){
                            additionalClassNames = "openPhenotype";
                        } else if (convertedSampleGroup === parentSG){
                            additionalClassNames += "openPhenotype";
                        }
                    }
                    retVal.push("<div id='traitsTable"+(rowCounter)+"' class='vandaRowHdr sgIdentifierInTraitTable "+additionalClassNames+"' datasetname='"+row['samplegroup']+"' phenotypename='"+phenotypeName+
                        "' samplegroup='"+row['samplegroup']+"' convertedSampleGroup='"+convertedSampleGroup+"' rowsPerPhenotype='"+rowsPerPhenotype.length+"'>");

                    // field 2: phenotype, which may or may not be a link.  for now, restrict this link to GWAS data sets
                    if (convertedSampleGroup.indexOf('GWAS')>-1){ // GWAS data set - allow anchor
                        retVal.push("<a href='"+traitRootUrl+"?trait="+phenotypeName+"&significance=5e-8'>"+convertedTrait+"</a>");
                    } else {
                        retVal.push("<div style='display:inline'>"+convertedTrait+"</div>");
                    }

                    // field 3: direction of pValue
                    if (!isNaN(pValue)) {
                        retVal.push(pValue.toPrecision(3));
                    } else {
                        retVal.push("");
                    }

                    // field 4: direction of effect
                    if ( rescueArrow === 1 ) {
                        retVal.push("<span class='assoc-up'>&uarr;</span>");
                    }
                    else if ( rescueArrow === -1 ) {
                        retVal.push("<span class='assoc-down'>&darr;</span>");
                    } else {
                        retVal.push("");
                    }

                    // field 5: odds ratio
                    if (!isNaN(oddsRatioValue)) {
                        retVal.push(oddsRatioValue.toPrecision(3));
                    } else {
                        retVal.push("");
                    }

                    // field 6: maf
                    if (!isNaN(mafValue)) {
                        retVal.push(mafValue.toPrecision(3));
                    } else {
                        retVal.push("");
                    }

                    // field 7: beta
                    if (!isNaN(betaValue)) {
                        retVal.push(betaValue.toPrecision(3));
                    } else {
                        retVal.push("");
                    }

                    rowCounter++;
                    $(traitsPerVariantTable).dataTable().fnAddData( retVal );
                }

            }
        }
        return retVal;
    };
    var contentExists = function (field){
        return ((typeof field !== 'undefined') && (field !== null) );
    };
    var noop = function (field){return field;};
    var lineBreakSubstitution = function (field){
        return (contentExists(field)) ? field.replace(/[;,]/g,'<br/>') : '';
    };


    /* Sort col is *relative* to dynamic columns */
    var iterativeVariantTableFiller = function  (data,      // all the table information--doesn't include the variants
                                                 totCol,    // total number of columns
                                                 sortCol,   // index of the column to sort by--currently defaults to the last p-value
                                                 divId,     // id of the div to attach to
                                                 variantRootUrl,    // url for the variant id link
                                                 geneRootUrl,       // url for the gene link
                                                 proteinEffectList,    // strings for protein effects
                                                 locale,            // if we need to display the table in Spanish
                                                 copyText,          // text to display in the copy button
                                                 printText,         // text to display in the print button
                                                 querySpecifications   // the filters and properties that are being requested
    ) {
        var languageSetting = {};
        // check if the browser is using Spanish
        if ( locale.startsWith("es")  ) {
            languageSetting = { url : '../../js/lib/i18n/table.es.json' }
        }

        // we've stored unique names to each column. they are structured <property>.<dataset>.<phenotype>--in
        // other words, the dot notation for how variant objects are returned. for dprops/cprops, the phenotype
        // and dataset parts do not exist as appropriate.
        // we do this to ensure that the right data is put in each column. without this, we'd have to guarantee
        // that the server and the client always order the columns in the same way.
        var headers = $('#variantTableHeaderRow3').children('th');
        var columnInfo = _.map(headers, function(header) {
            var name = $(header).attr('data-colname');
            return {
                name: name,
                data: name,
                // don't show anything if the data is undefined
                defaultContent: '',
                // this is the function that allows us to format the data
                render: function(data, type, full, meta) {
                    // if Datatables is calling this function to do anything besides display data (ex. sorting),
                    // just return the data without processing it
                    if(type != 'display') {
                        return data;
                    }
                    // this is the really roundabout way of knowing which field we're working with
                    var columnName = meta.settings.aoColumns[meta.col].colname;
                    // if columnName has 2 periods, then it's a pprop. 1 period, it's a dprop.
                    // no periods, it's a cprop. The easy way to get the number of periods is split the
                    // name on '.', and count the number of elements we have.
                    var whatKindOfPropertyIsThis = columnName.split('.').length;
                    if(whatKindOfPropertyIsThis == 3 || whatKindOfPropertyIsThis == 2) {
                        // pprop or dprop
                        // if the number is already an integer (in which case the rounded value is equal to itself) don't do anything
                        // otherwise, pass the number through UTILS.realNumberFormatter
                        return getSimpleString(true, Math.round(data) == data ? noop : UTILS.realNumberFormatter, data, "");
                    } else if(whatKindOfPropertyIsThis == 1) {
                        // cprop
                        switch(columnName) {
                            case "VAR_ID":
                                return getStringWithLinkForVarId(variantRootUrl, (contentExists(variantRootUrl) && data), noop, data, full.CHROM + ':' + full.POS, data);
                            case "CHROM":
                            case "POS":
                            case "DBSNP_ID":
                            case "IN_GENE":
                            case "Protein_change":
                            case "IN_EXSEQ":
                            case "Condel_PRED":
                            case "MOST_DEL_SCORE":
                            case "PolyPhen_PRED":
                            case "SIFT_PRED":
                            case "TRANSCRIPT_ANNOT":
                                return getSimpleString(data, noop, data, "");
                            case "CLOSEST_GENE":
                            case "GENE":
                                return getStringWithLink(geneRootUrl,(geneRootUrl && data), noop, data, data, "");
                            case "Consequence":
                                var contingent = (data) && (contentExists(proteinEffectList)) && (contentExists(proteinEffectList.proteinEffectMap)) && (contentExists(proteinEffectList.proteinEffectMap[data]));
                                var displayField = proteinEffectList.proteinEffectMap[data];
                                var alternate = lineBreakSubstitution((data && (data !== 'null')) ? data : "");
                                return getSimpleString(contingent, lineBreakSubstitution, displayField, alternate);
                            default:
                                return getSimpleString(data, noop, data, "");
                        }
                    } else {
                        // just in case
                        return data;
                    }
                }
            };
        });

        console.log('querySpecifications.properties:', querySpecifications.properties);

        var table = $(divId).dataTable({
            // so that we can regenerate the table if the inputs change
            destroy: true,
            // default number of rows
            pageLength: 25,
            // menu to select number of rows to display
            lengthMenu: [ 10, 25, 50, 1000 ],
            // defaults to sorting the first p-value column found when generating the columns
            order: [[ sortCol, 'asc' ]],
            language: languageSetting,
            columns: columnInfo,
            // this means that all data manipulation takes place on the server, including sorting
            // the table just displays things
            serverSide: true,
            ajax: {
                url: '../variantSearchAndResultColumnsData',
                data: function(d) {
                    d.filters = querySpecifications.filters;
                    d.properties = querySpecifications.properties;
                    // d.properties = '';
                    d.numberOfVariants = data.numberOfVariants;
                    // need to stringify because otherwise Groovy gets a lot of
                    // parameters that aren't grouped correctly
                    d.columns = JSON.stringify(d.columns);
                    d.order = JSON.stringify(d.order);
                }
            },
            dom: 'lBtip',
            buttons: [
                { extend: "copy", text: copyText },
                'csv',
                { extend: 'pdf', orientation: 'landscape'},
                { extend: "print", text: printText }
            ],
            drawCallback: function(settings) {
                $('#spinner').hide();
            }
        });

    };


    var getStringWithLink  = function(urlRoot, contingent, modder, linkField,displayField, alternate){
        var retVal = alternate;
        if (contingent){
            retVal = "<a  href='"+urlRoot+"/"+linkField+"' class='boldItlink'>"+modder(displayField);
        }
        return retVal

    };
    var getStringWithLinkForVarId  = function(urlRoot, contingent, modder, linkField,displayField, alternate){
        var retVal = alternate;
        if (contingent){
            if (displayField) {
                if (displayField.indexOf('undefined') === -1)   {
                    retVal = "<a  href='" + urlRoot + "/" + linkField + "' class='boldItlink'>" + modder(displayField);
                }  else {
                    retVal = "<a  href='" + urlRoot + "/" + linkField + "' class='boldItlink'>" + modder(alternate);
                }
            }
        }
        return retVal
    };
    var getSimpleString  = function(contingent,  modder,  displayField, alternate){
        var retVal = alternate;
        if(contingent === true) {
            // debugger
        }
        if (contingent){
            retVal = ""+ modder (displayField);
        }
        return retVal
    };

    return {
        addTraitsPerVariantTable:addTraitsPerVariantTable,
        iterativeVariantTableFiller:iterativeVariantTableFiller,
    }

}());