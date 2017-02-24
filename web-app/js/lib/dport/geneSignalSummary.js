var mpgSoftware = mpgSoftware || {};




mpgSoftware.geneSignalSummaryMethods = (function () {
    var loading = $('#rSpinner');


    var buildCommonTable = function(selectionToFill,
                                    variantInfoUrl,
                                      cvar){

        var commonTable  = $(selectionToFill).dataTable({
                "bDestroy": true,
                "className": "compact",
                "bAutoWidth" : false,
                "order": [[ 1, "asc" ]],
                "columnDefs": [
                     { "name": "VAR_ID",   "targets": [0], "type":"allAnchor", "title":"Variant ID",
                        "sWidth": "20%" },
                    { "name": "DBSNP_ID",   "targets": [1], "title":"dbSNP ID",
                        "sWidth": "15%"  },
                    { "name": "PVALUE",   "targets": [2], "title":"p-Value",
                        "sWidth": "15%"  },
                    { "name": "EFFECT",   "targets": [3], "title":"Effect",
                        "sWidth": "15%" },
                    { "name": "DS",   "targets": [4], "title":"Data set",
                        "sWidth": "35%" }
                ],
                "order": [[ 2, "asc" ]],
                "scrollY":        "300px",
                "scrollCollapse": true,
                "paging":         false,
                "bFilter": true,
                "language": {
                    "search": "Filter:"
                },
                "bLengthChange" : true,
                "bInfo":false,
                "bProcessing": true,
                "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
                   nRow.className = $(aData[0]).attr('custag');
                   return nRow;
                 }
            }
        );
        _.forEach(cvar,function(variantRec){
            var arrayOfRows = [];
            var variantID = variantRec.id;
            arrayOfRows.push('<a href="'+variantInfoUrl+'/'+variantID+'" class="boldItlink" custag="'+variantRec.CAT+'">'+variantID+'</a>');
            var DBSNP_ID = (variantRec.rsId)?variantRec.rsId:'';
            arrayOfRows.push(DBSNP_ID);
            arrayOfRows.push(variantRec.P_VALUE);
            arrayOfRows.push(variantRec.BETA);
            arrayOfRows.push(variantRec.dsr);
            commonTable.dataTable().fnAddData( arrayOfRows );
        });
        $('div.dataTables_scrollHeadInner table.dataTable thead tr').addClass('niceHeaders');
    };



    var buildHighImpactTable = function(selectionToFill,
                                    variantInfoUrl,
                                    rvar){

        var highImpactTable  = $(selectionToFill).dataTable({
                "bDestroy": true,
                "className": "compact",
                "bAutoWidth" : false,
                "order": [[ 1, "asc" ]],
                "columnDefs": [
                    { "name": "VAR_ID",   "targets": [0], "type":"allAnchor", "title":"Variant ID",
                        "sWidth": "16%" },
                    { "name": "DBSNP_ID",   "targets": [1], "title":"dbSNP ID",
                        "sWidth": "13%"  },
                    { "name": "PREDICTED",   "targets": [2], "title":"Predicted<br/>impact",
                        "sWidth": "13%"  },
                    { "name": "PVALUE",   "targets": [3], "title":"p-Value",
                        "sWidth": "13%"  },
                    { "name": "EFFECT",   "targets": [4], "title":"Effect",
                        "sWidth": "15%" },
                    { "name": "DS",   "targets": [5], "title":"Data set",
                        "sWidth": "30%" }
                ],
                "order": [[ 3, "asc" ]],
                "scrollY":        "300px",
                "scrollCollapse": true,
                "paging":         false,
                "bFilter": true,
                "language": {
                    "search": "Filter:"
                },
                "bLengthChange" : true,
                "bInfo":false,
                "bProcessing": true,
                "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
                    nRow.className = $(aData[0]).attr('custag');
                    return nRow;
                }
            }
        );
        _.forEach(rvar,function(variantRec){
            var arrayOfRows = [];
            var variantID = variantRec.id;
            arrayOfRows.push('<a href="'+variantInfoUrl+'/'+variantID+'" class="boldItlink" custag="'+variantRec.CAT+'">'+variantID+'</a>');
            var DBSNP_ID = (variantRec.rsId)?variantRec.rsId:'';
            arrayOfRows.push(DBSNP_ID);
            arrayOfRows.push(variantRec.deleteriousness);
            arrayOfRows.push(variantRec.P_VALUE);
            arrayOfRows.push(variantRec.BETA);
            arrayOfRows.push(variantRec.dsr);
            highImpactTable.dataTable().fnAddData( arrayOfRows );
        });
        $('div.dataTables_scrollHeadInner table.dataTable thead tr').addClass('niceHeaders');
    };

    var phenotypeNameForSampleData  = function (untranslatedPhenotype) {
        var convertedName = '';
        if (untranslatedPhenotype === 'T2D') {
            convertedName = 't2d';
        } else if (untranslatedPhenotype === 'FG') {
            convertedName = 'FAST_GLU_ANAL';
        } else if (untranslatedPhenotype === 'FI') {
            convertedName = 'FAST_INS_ANAL';
        } else if (untranslatedPhenotype === 'BMI') {
            convertedName = 'BMI';
        } else if (untranslatedPhenotype === 'CHOL') {
            convertedName = 'CHOL_ANAL';
        } else if (untranslatedPhenotype === 'TG') {
            convertedName = 'TG_ANAL';
        } else if (untranslatedPhenotype === 'HDL') {
            convertedName = 'HDL_ANAL';
        } else if (untranslatedPhenotype === 'LDL') {
            convertedName = 'LDL_ANAL';
        } else if (untranslatedPhenotype === 'SBP') {
            convertedName = 'SBP_ANAL';
        } else if (untranslatedPhenotype === 'DBP') {
            convertedName = 'DBP_ANAL';
        }
        return convertedName;
    };
    var phenotypeNameForHailData  = function (untranslatedPhenotype) {
        var convertedName;
        if (untranslatedPhenotype === 'T2D') {
            convertedName = {key: "T2D", description: "Type 2 Diabetes"};
        } else if (untranslatedPhenotype === 'BMI') {
            convertedName = {key: "BMI_adj_withincohort_invn", name: "BMI", description: "Body Mass Index"};
        } else if (untranslatedPhenotype === 'LDL') {
            convertedName = {key: "LDL_lipidmeds_divide.7_adjT2D_invn", name: "LDL", description: "LDL Cholesterol"};
        } else if (untranslatedPhenotype === 'HDL') {
            convertedName = {key: "HDL_adjT2D_invn", name: "HDL", description: "HDL Cholesterol"};
        } else if (untranslatedPhenotype === 'FI') {
            convertedName = {key: "logfastingInsulin_adj_invn", name: "FI", description: "Fasting Insulin"};
        } else if (untranslatedPhenotype === 'FG') {
            convertedName = {key: "fastingGlucose_adj_invn", name: "FG", description: "Fasting Glucose"};
        } else if (untranslatedPhenotype === 'HIPC') {
            convertedName = {key: "HIP_adjT2D_invn", name: "HIP", description: "Hip Circumference"};
        } else if (untranslatedPhenotype === 'WAIST') {
            convertedName = {key: "WC_adjT2D_invn", name: "WC", description: "Waist Circumference"};
        } else if (untranslatedPhenotype === 'WHR') {
            convertedName = {key: "WHR_adjT2D_invn", name: "WHR", description: "Waist Hip Ratio"};
        } else if (untranslatedPhenotype === 'SBP') {
            convertedName = {key: "TC_adjT2D_invn", name: "TC", description: "Total Cholesterol"};
        } else if (untranslatedPhenotype === 'DBP') {
            convertedName = {key: "TG_adjT2D_invn", name: "TG", description: "Triglycerides"};
        }
        return convertedName;
    };
    var processAggregatedData = function (v) {
        var obj = {};
        var procAggregatedData = function (val, key) {
            var mafValue;
            var mdsValue;
            var pValue;
            if (key === 'VAR_ID') {
                obj['id'] = (val) ? val : '';
            } else if (key === 'DBSNP_ID') {
                obj['rsId'] = (val) ? val : '';
            } else if (key === 'Protein_change') {
                obj['impact'] = (val) ? val : '';
            } else if (key === 'Consequence') {
                obj['deleteriousness'] = (val) ? val : '';
            } else if (key === 'Reference_Allele') {
                obj['referenceAllele'] = (val) ? val : '';
            } else if (key === 'Effect_Allele') {
                obj['effectAllele'] = (val) ? val : '';
            } else if (key === 'MOST_DEL_SCORE') {
                obj['MOST_DEL_SCORE'] = (val) ? val : '';
            } else if (key === 'dataset') {
                obj['ds'] = (val) ? val : '';
            } else if (key === 'dsr') {
                obj['dsr'] = (val) ? val : '';
            } else if (key === 'pname') {
                obj['pname'] = (val) ? val : '';
            } else if (key === 'phenotype') {
                obj['pheno'] = (val) ? val : '';
            } else if (key === 'datasetname') {
                obj['datasetname'] = (val) ? val : '';
            } else if (key === 'meaning') {
                obj['meaning'] = (val) ? val : '';
            } else if (key === 'AF') {
                obj['MAF'] = UTILS.realNumberFormatter((val) ? val : 1);
            } else if ((key === 'P_FIRTH_FE_IV') ||
                (key === 'P_VALUE') ||
                (key === 'P_FE_INV') ||
                (key === 'P_FIRTH')
            ) {
                obj['property'] = key;
                obj['P_VALUE'] = UTILS.realNumberFormatter((val) ? val : 1);
                obj['P_VALUEV'] = (val) ? val : 1;
            } else if (key === 'BETA') {
                obj['BETA'] = UTILS.realNumberFormatter(Math.exp((val) ? val : 1));
                obj['BETAV'] = Math.exp((val) ? val : 1);

            }
            return obj;
        }
        _.forEach(v, procAggregatedData);
        return obj;
    };
    var refineRenderData = function (renderData, significanceLevel) {
        renderData.rvar = [];
        renderData.cvar = [];
        var pValueCutoffHighImpact = 0;
        var pValueCutoffCommon = 0;
        var maxNumberOfVariants = 100;
        switch (significanceLevel) {
            case 3:
                pValueCutoffHighImpact = 0.00000005;
                pValueCutoffCommon = 0.000005;
                break;
            case 2:
                pValueCutoffHighImpact = 0.0001;
                pValueCutoffCommon = 0.0001;
                break;
            case 1:
                pValueCutoffHighImpact = 1;
                pValueCutoffCommon = 1;
                break;
            default:
                break;
        }
        var rvart = [];
        var cvart = [];
        _.forEach(renderData.variants, function (v) {
            var mafValue = v['MAF']
            var mdsValue = v['MOST_DEL_SCORE'];
            var pValue = v['P_VALUEV'];
            if ((typeof mdsValue !== 'undefined') && (mdsValue !== '') && (mdsValue < 3) &&
                (typeof pValue !== 'undefined') && (pValue <= pValueCutoffHighImpact)) {
                if (rvart.length < maxNumberOfVariants) {
                    if (pValue < 0.000005) {
                        v['CAT'] = 'greenline'
                    }
                    else if (pValue < 0.0005) {
                        v['CAT'] = 'yellowline'
                    }
                    else {
                        v['CAT'] = 'redline'
                    }
                    rvart.push(v);
                }
            }
            if ((typeof mafValue !== 'undefined') && (mafValue !== '') && (mafValue > 0.05) &&
                (typeof pValue !== 'undefined') && (pValue <= pValueCutoffCommon)) {
                if (cvart.length < maxNumberOfVariants) {
                    if (pValue < 0.00000005) {
                        v['CAT'] = 'greenline'
                    }
                    else if (pValue < 0.0005) {
                        if (v['CAT']!='greenline'){
                            v['CAT'] = 'yellowline'
                        }
                    }
                    else {
                        if ((v['CAT']!=='greenline')&&
                            (v['CAT']!=='yellowline')) {
                            v['CAT'] = 'redline'
                        }
                    }
                    cvart.push(v);
                }
            }
        });
        // sort by P value for the high-impact variants
        var tempRVar = _.sortBy(rvart, function (o) {
            return o.P_VALUEV
        });
        // Only the first P value with each name gets in.  Since these are sorted we get all the variants with the lowest P values
        _.forEach(tempRVar,function(o){
            if (_.findIndex(renderData.rvar,function (p){return (p['id']==o['id'])})<0){
                renderData.rvar.push(o);
            }
        });
        // repeat the sorting and filtering for the common variants
        var tempCVar = _.sortBy(cvart, function (o) {
            return o.P_VALUEV
        });
        _.forEach(tempCVar,function(o){
            if (_.findIndex(renderData.cvar,function (p){return (p['id']==o['id'])})<0){
                renderData.cvar.push(o);
            }
        });
        return renderData;
    };

    var buildRenderData = function (data, mafCutoff) {
        var renderData = {variants: [],
            rvar: [],
            cvar: []};
        if ((typeof data !== 'undefined') &&
            (typeof data.variants !== 'undefined') &&
            (typeof data.variants.variants !== 'undefined') &&
            (data.variants.variants.length > 0)) {
            var obj;
            _.forEach(data.variants.variants, function (v, index, y) {
                if (_.flatten(v).length == 0) {
                    renderData.variants.push(mpgSoftware.geneSignalSummaryMethods.processAggregatedData(v));
                } else {
                    renderData.variants.push(mpgSoftware.geneSignalSummaryMethods.processAggregatedData(v));
                }

            });
        }
        ;
        return renderData;
    };


    var updateAggregateVariantsDisplay = function (data, locToUpdate) {
        var updateHere = $(locToUpdate);
        updateHere.empty();
        if ((data) &&
            (data.stats)) {
            updateHere.append("<ul class='aggregateVariantsDescr list-group'>" +
                "<li class='list-group-item'>" + UTILS.realNumberFormatter(data.stats.pValue) + "</li>" +
                "<li class='list-group-item'>" + UTILS.realNumberFormatter(data.stats.beta) + "</li>" +
                "<li class='list-group-item'>" + UTILS.realNumberFormatter(data.stats.ciLower) + " : " + UTILS.realNumberFormatter(data.stats.ciUpper) + "</li>" +
                "</ul>");
            if (data.stats.pValue < 0.000001) {
                mpgSoftware.geneSignalSummary.updateDisplayBasedOnStoredSignificanceLevel(3);//green light
            } else if (data.stats.pValue < 0.01) {
                mpgSoftware.geneSignalSummary.updateDisplayBasedOnStoredSignificanceLevel(2);//yellow light
            }

        }
    };


    var commonSectionComesFirst = function (renderData) { // returns true or false
        var returnValue;
        var sortedVariants = _.sortBy(renderData.variants, function (o) {
            return o.P_VALUEV
        });
        for (var i = 0; (i < sortedVariants.length) && (typeof returnValue === 'undefined'); i++) {
            var oneVariant = sortedVariants[i];
            if ((typeof oneVariant.MAF !== 'undefined') && (oneVariant.MAF !== "")) {
                if (oneVariant.MAF < 0.05) {
                    returnValue = false;
                } else {
                    returnValue = true;
                }
            }
            if (typeof oneVariant.MOST_DEL_SCORE !== 'undefined') {
                if ((oneVariant.MOST_DEL_SCORE < 3)&&
                    ((typeof returnValue !== 'undefined')&&(returnValue !== true))) {
                    returnValue = false;
                }
            }
        }
        return returnValue;
    }


    var buildListOfInterestingPhenotypes = function (renderData) {
        var listOfInterestingPhenotypes = [];
        _.forEach(renderData.variants, function (v) {
            var newSignalCategory = assessOneSignalsSignificance(v);
            if (newSignalCategory > 0) {
                var existingRecIndex = _.findIndex(listOfInterestingPhenotypes, {'phenotype': v['pheno']});
                if (existingRecIndex > -1) {
                    var existingRec = listOfInterestingPhenotypes[existingRecIndex];
                    if (existingRec['signalStrength'] < newSignalCategory) {
                        existingRec['signalStrength'] = newSignalCategory;
                    }
                    if (existingRec['pValue'] > v['P_VALUEV']) {
                        existingRec['pValue'] = v['P_VALUEV'];
                        existingRec['ds'] = v['ds'];
                        existingRec['pname'] = v['pname'];
                    }
                } else {
                    listOfInterestingPhenotypes.push({  'phenotype': v['pheno'],
                        'ds': v['ds'],
                        'pname': v['pname'],
                        'signalStrength': newSignalCategory,
                        'pValue': v['P_VALUEV']})
                }
            }
        });
        return _.sortBy(listOfInterestingPhenotypes,[function(o){return o.pValue}]);
    };

    function toggleOtherPhenoBtns(){
        var otherBtns = $('.nav>li.redPhenotype');
        if ((typeof otherBtns !== 'undefined')&&
            (otherBtns.length>0)){
            if ($(otherBtns[0]).css('display')==='none') {
                $(otherBtns).css('display','block');
                $('a.morePhenos').css('display','none');
                $('a.noMorePhenos').css('display','block');
            } else {
                $(otherBtns).css('display','none');
                $('a.morePhenos').css('display','block');
                $('a.noMorePhenos').css('display','none');
            }
        }
    };
    var launchUpdateSignalSummaryBasedOnPhenotype = function (phenocode,ds,phenoName) {
        $('.phenotypeStrength').removeClass('chosenPhenotype');
        $('#'+phenocode).addClass('chosenPhenotype');
        mpgSoftware.geneSignalSummary.refreshTopVariantsDirectlyByPhenotype(phenocode,
            mpgSoftware.geneSignalSummary.updateSignificantVariantDisplay,{updateLZ:true,phenotype:phenocode,pname:phenoName,ds:ds,preferIgv:$('.preferIgv').is(":checked")});
    };
    var updateSignalSummaryBasedOnPhenotype = function () {
        var phenocode = $(this).attr('id');
        var ds = $(this).attr('ds');
        var phenoName = $(this).text();
        launchUpdateSignalSummaryBasedOnPhenotype(phenocode,ds,phenoName);
    };
    var refreshSignalSummaryBasedOnPhenotype = function () {
        var phenocode = $('.phenotypeStrength.chosenPhenotype').attr('id');
        var ds = $('.phenotypeStrength.chosenPhenotype').attr('ds');
        var phenoName = $('.phenotypeStrength.chosenPhenotype').text();
        launchUpdateSignalSummaryBasedOnPhenotype(phenocode,ds,phenoName);
    };
    var displayInterestingPhenotypes = function (data,params) {
        var renderData = buildRenderData(data, 0.05);
        var signalLevel = assessSignalSignificance(renderData);
        updateDisplayBasedOnSignificanceLevel(signalLevel,params);
        var listOfInterestingPhenotypes = buildListOfInterestingPhenotypes(renderData);
        if (listOfInterestingPhenotypes.length > 0) {
            $('.interestingPhenotypesHolder').css('display','block');
            var phenotypeDescriptions = '<label>Phenotypes with signals</label>'+

                '<ul class="nav nav-pills">';
            _.forEach(listOfInterestingPhenotypes, function (o) {
                if (o['signalStrength'] == 1) {
                    phenotypeDescriptions += ('<li id="'+o['phenotype']+'" ds="'+o['ds']+'" class="nav-item redPhenotype phenotypeStrength">' + o['pname'] + '</li>');
                } else if (o['signalStrength'] == 2) {
                    phenotypeDescriptions += ('<li id="'+o['phenotype']+'" ds="'+o['ds']+'" class="nav-item yellowPhenotype phenotypeStrength">' + o['pname'] + '</li>');
                } else if (o['signalStrength'] == 3) {
                    phenotypeDescriptions += ('<li id="'+o['phenotype']+'" ds="'+o['ds']+'" class="nav-item greenPhenotype phenotypeStrength">' + o['pname'] + '</li>');
                }
            });
            phenotypeDescriptions += ('<li><a href="#" class="morePhenos"  onclick="mpgSoftware.geneSignalSummaryMethods.toggleOtherPhenoBtns()">Additional phenotypes...</a></li>');
            phenotypeDescriptions += ('<li><a href="#" class="noMorePhenos" style="display:none" onclick="mpgSoftware.geneSignalSummaryMethods.toggleOtherPhenoBtns()">Collapse phenotypes without signals</a></li>');
            phenotypeDescriptions += '</ul>';
            $('#interestingPhenotypes').append(phenotypeDescriptions);

        }

        $('.phenotypeStrength').on("click",updateSignalSummaryBasedOnPhenotype);
        $('.phenotypeStrength').first().click();
    };

    var assessOneSignalsSignificance = function (v,signalCategory) {
        var signalCategory = 1;
        var mdsValue = parseInt(v['MOST_DEL_SCORE']);
        var pValue = parseFloat(v['P_VALUEV']);
        if (((pValue < 0.00000005)) ||
            ( (pValue < 0.000005) &&
                (mdsValue < 3) )) {
            signalCategory = 3;
        } else if (pValue < 0.0005) {
            signalCategory = 2;
        }
        return signalCategory;
    };
    var assessSignalSignificance = function (renderData){
        var signalCategory = 1; // 1 == red (no signal), 3 == green (signal)
        _.forEach(renderData.variants,function(v){
            var newSignalCategory = assessOneSignalsSignificance(v);
            if (newSignalCategory>signalCategory){
                signalCategory = newSignalCategory;
            }
        });
        return signalCategory;
    };
    var updateDisplayBasedOnSignificanceLevel = function (significanceLevel,params) {


        var significanceLevelDoms = $('.trafficExplanations');

        significanceLevelDoms.removeClass('emphasize');
        significanceLevelDoms.addClass('unemphasize');


        $('#trafficLightHolder').empty();
        var significanceLevelDom = $('.trafficExplanation'+significanceLevel);
        significanceLevelDom.removeClass('unemphasize');
        significanceLevelDom.addClass('emphasize');
        if (significanceLevel == 1){
            $('#trafficLightHolder').append(params.redLightImage);
        } else if (significanceLevel == 2){
            $('#trafficLightHolder').append(params.yellowLightImage);
        } else if (significanceLevel == 3){
            $('#trafficLightHolder').append(params.greenLightImage);
        }
        $('#signalLevelHolder').text(significanceLevel);
    };





// public routines are declared below
    return {
        buildCommonTable:buildCommonTable,
        buildHighImpactTable:buildHighImpactTable,
        processAggregatedData:processAggregatedData,
        phenotypeNameForSampleData:phenotypeNameForSampleData,
        phenotypeNameForHailData:phenotypeNameForHailData,
        refineRenderData:refineRenderData,
        buildRenderData:buildRenderData,
        updateAggregateVariantsDisplay:updateAggregateVariantsDisplay,
        commonSectionComesFirst:commonSectionComesFirst,
        toggleOtherPhenoBtns:toggleOtherPhenoBtns,
        refreshSignalSummaryBasedOnPhenotype:refreshSignalSummaryBasedOnPhenotype,
        displayInterestingPhenotypes:displayInterestingPhenotypes,
        assessSignalSignificance:assessSignalSignificance,
        updateDisplayBasedOnSignificanceLevel:updateDisplayBasedOnSignificanceLevel
    }

}());

