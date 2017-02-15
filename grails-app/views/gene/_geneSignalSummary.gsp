<style>
.trafficExplanations {
    margin: 8px 0 10px 0;
    font-family: "Times New Roman", Times, serif;
    font-style: normal;
    font-size: 24px;
    font-weight: 100;
}
.interestingPhenotypesHolder{
    margin: 30px 30px 0 0;
    padding: 20px 30px 10px 0;
    border: 0.5px solid gray;
    display: none;
}
#phenotypeLabel{
    font-size: 32px;
    font-weight: bold;
}
#burdenGoesHere .panel-group{
    margin-right: 42px;
}
#burdenGoesHere .secBody {
    padding-right: 40px;
}
#burdenGoesHere .burden-test-specific-results{
    margin-right: 40px;
}
.trafficExplanations.emphasize {
    font-weight: 900;
}
.trafficExplanations.unemphasize {
    font-weight: normal;
}
.phenotypeStrength {
    cursor:pointer;
    margin: 10px;
    border: 1px solid black;
    padding: 5px;
    background-color: white;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    border-radius: 10px;
    -webkit-box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.4);
    -moz-box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.4);
    box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.4);
}
.redPhenotype {
    background-color: #dddddd;
}
.nav>li.redPhenotype {
    display: none;
}
.yellowPhenotype {
    background-color: #ffffb3;
}
.greenPhenotype {
    background-color: #ccffcc;
}
div.redline {
 /*   background-color: #ffb3b3;*/
}
div.yellowline {
     background-color: #ffffb3;
}
div.greenline {
      background-color: #ccffcc;
  }
.linkEmulator{
    text-decoration: underline;
    cursor: pointer;
    font-style: italic;
    color: #588fd3;
}
.boxOfVariants {
    border: 1px solid black;
    padding: 10px;
    max-height: 200px;
    overflow-y: auto;
    overflow-x: hidden;
}
div.variantCategoryLabel{
    margin-left:20px;
}
span.aggregatingVariantsColumnHeader {
    font-weight: bold;
}
ul.aggregatingVariantsLabels>li {
    padding: 18px 0 0 0;
    font-weight: bold;
}
ul.aggregatingVariantsLabels {
    list-style-type: none;
    padding: 18px 0 0 0;
}
.aggregateVariantsDescr {
    font-size: 12px;
}
.aggregateVariantsDescr+li {
    list-style-type: none;
    font-size: 11px;
}
.specialTitle {
    font-weight: bold;
}
div.variantBoxHeaders {
    padding: 10px;
    font-size: 16px;
}
</style>

<div class="row">
    <div class="pull-right" style="display:none">
        <label for="signalPhenotypeTableChooser"><g:message code="gene.variantassociations.change.phenotype"
                                                            default="Change phenotype choice"/></label>
        &nbsp;
        <select id="signalPhenotypeTableChooser" name="phenotypeTableChooser"
                onchange="mpgSoftware.geneSignalSummary.refreshTopVariantsByPhenotype(this,mpgSoftware.geneSignalSummary.updateSignificantVariantDisplay)">
        </select>
    </div>
</div>
<div class="panel panel-default">%{--should hold the Choose data set panel--}%
    <div class="panel-heading" style="background-color: #E0F3FD">
        <div class="row">
            <div class="col-md-2 col-xs-12">
                <div id='trafficLightHolder'>
                    <r:img uri="/images/undeterminedlight.png"/>
                    <div id="signalLevelHolder" style="display:none"></div>
                </div>

            </div>

            <div class="col-md-8 col-xs-12">
                <div class="row">
                    <div class="col-lg-12 trafficExplanations trafficExplanation1">
                        Evidence of no signal
                    </div>

                    <div class="col-lg-12 trafficExplanations trafficExplanation2">
                        Absence of strong evidence
                    </div>

                    <div class="col-lg-12 trafficExplanations trafficExplanation3">
                        Signal exists
                    </div>
                </div>
            </div>

            <div class="col-md-2 col-xs-12">
                <button name="singlebutton"
                        class="btn btn-secondary btn-lg burden-test-btn vcenter"
                        type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">Summary</button>
            </div>

        </div>
        <div class="row interestingPhenotypesHolder">
            <div class="col-xs-12">
            <div id="interestingPhenotypes">

            </div>
            </div>
        </div>

    </div>

</div>
<div class="collapse in" id="collapseExample">
    <div class="well">

    <div id="noAggregatedVariantsLocation">
        <div class="row" style="margin-top: 15px;">
            <div class="col-lg-offset-1">
                <h4>No information about aggregated variants exists for this phenotype</h4>
            </div>
        </div>
    </div>


    </div>
</div>

<div id="locusZoomTemplate"  type="x-tmpl-mustache" style="display:none">
        <div style="margin-top: 20px">

            <div style="display: flex; justify-content: space-around;">
                <p>Linkage disequilibrium (r<sup>2</sup>) with the reference variant:</p>

                <p><i class="fa fa-circle" style="color: #d43f3a"></i> 1 - 0.8</p>

                <p><i class="fa fa-circle" style="color: #eea236"></i> 0.8 - 0.6</p>

                <p><i class="fa fa-circle" style="color: #5cb85c"></i> 0.6 - 0.4</p>

                <p><i class="fa fa-circle" style="color: #46b8da"></i> 0.4 - 0.2</p>

                <p><i class="fa fa-circle" style="color: #357ebd"></i> 0.2 - 0</p>

                <p><i class="fa fa-circle" style="color: #B8B8B8"></i> no information</p>

                <p><i class="fa fa-circle" style="color: #9632b8"></i> reference variant</p>
            </div>
            <ul class="nav navbar-nav navbar-left" style="display: flex;">
                <li class="dropdown" id="tracks-menu-dropdown-dynamic">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Phenotypes (dynamic)<b class="caret"></b></a>
                    <ul id="trackList-dynamic" class="dropdown-menu">
                        <g:each in="${lzOptions?.findAll{it.dataType=='dynamic'}}">
                            <li>
                                <a onclick="mpgSoftware.locusZoom.addLZPhenotype({
                                            phenotype: '${it.key}',
                                            dataSet: '${it.dataSet}',
                                            propertyName: '${it.propertyName}',
                                            description: '${it.description}'
                                        },
                                        '${it.dataSet}','${createLink(controller:"gene", action:"getLocusZoom")}',
                                        '${createLink(controller:"variantInfo", action:"variant")}',
                                        '${it.dataType}','#lz-1')">
                                    ${g.message(code: "metadata." + it.name)}
                                </a>
                            </li>
                        </g:each>
                    </ul>
                </li>
                <li class="dropdown" id="tracks-menu-dropdown-static">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Phenotypes (static)<b class="caret"></b></a>
                    <ul id="trackList-static" class="dropdown-menu">
                        <g:each in="${lzOptions?.findAll{it.dataType=='static'}}">
                            <li>
                                <a onclick="mpgSoftware.locusZoom.addLZPhenotype({
                                            phenotype: '${it.key}',
                                            dataSet: '${it.dataSet}',
                                            propertyName: '${it.propertyName}',
                                            description: '${it.description}'
                                        },
                                        '${it.dataSet}','${createLink(controller:"gene", action:"getLocusZoom")}',
                                        '${createLink(controller:"variantInfo", action:"variant")}',
                                        '${it.dataType}','#lz-1')">
                                    ${g.message(code: "metadata." + it.name)}
                                </a>
                            </li>
                        </g:each>
                    </ul>
                </li>

                <li style="margin: auto;">
                    <b>Region: <span id="lzRegion"></span></b>
                </li>
            </ul>

            <div class="accordion-inner">
                <div id="lz-1" class="lz-container-responsive"></div>
            </div>

        </div>
 </div>


<script id="aggregateVariantsTemplate"  type="x-tmpl-mustache">
                            <div class="row" style="margin-top: 15px;">
                                <h3 class="specialTitle">Aggregate variants</h3>
                            </div>

                            <div class="row">
                                <div class="col-lg-1">
                                            <ul class='aggregatingVariantsLabels'>
                                              <li style="text-align: right">beta</li>
                                              <li style="text-align: right">pValue</li>
                                              <li style="text-align: right">CI (95%)</li>
                                            </ul>
                                </div>
                                <div class="col-lg-11">
                                    <div class="boxOfVariants">
                                        <div class="row">
                                            <div class="col-lg-2 text-center"><span class="aggregatingVariantsColumnHeader">all variants</span>
                                                <div id="allVariants"></div>
                                            </div>

                                            <div class="col-lg-2 text-center"><span class="aggregatingVariantsColumnHeader">all coding</span>
                                                <div id="allCoding"></div>
                                            </div>

                                            <div class="col-lg-2 text-center"><span class="aggregatingVariantsColumnHeader">PTV + NS 1%</span>
                                                <div id="allMissense"></div>
                                            </div>

                                            <div class="col-lg-2 text-center"><span class="aggregatingVariantsColumnHeader">PTV+ NSbroad 1%</span>
                                                <div id="possiblyDamaging"></div>
                                            </div>

                                            <div class="col-lg-2 text-center"><span class="aggregatingVariantsColumnHeader">PTV + NSstrict</span>
                                                <div id="probablyDamaging"></div>
                                            </div>

                                            <div class="col-lg-2 text-center"><span class="aggregatingVariantsColumnHeader">PTV</span>
                                                <div id="proteinTruncating"></div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </script>


<script id="highImpactTemplate"  type="x-tmpl-mustache">
            <div class="row" style="margin-top: 15px;">
                <h3 class="specialTitle">High impact variants</h3>
            </div>

            <div class="row">
                <div class="col-lg-12">

                            <div class="row variantBoxHeaders">
                                <div class="col-lg-2">Variant ID</div>

                                <div class="col-lg-2">dbSNP Id</div>

                                <div class="col-lg-1">Protein<br/>change</div>

                                <div class="col-lg-2">Predicted<br/>impact</div>

                                <div class="col-lg-1">p-Value</div>

                                <div class="col-lg-1">Effect</div>
                                <div class="col-lg-3">Data set</div>
                            </div>

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="boxOfVariants">
                                        {{ #rvar }}
                                            <div class="row  {{CAT}}">
                                                <div class="col-lg-2"><a href="${createLink(controller: 'variantInfo', action: 'variantInfo')}/{{id}}" class="boldItlink">{{id}}</a></div>

                                                <div class="col-lg-2"><span class="linkEmulator" onclick="mpgSoftware.geneSignalSummary.refreshLZ('{{id}}','{{dsr}}','{{pname}}','{{pheno}}')" class="boldItlink">{{rsId}}</a></div>


                                                <div class="col-lg-1">{{impact}}</div>

                                                <div class="col-lg-2">{{deleteriousness}}</div>

                                                <div class="col-lg-1">{{P_VALUE}}</div>

                                                <div class="col-lg-1">{{BETA}}</div>
                                                <div class="col-lg-3">{{dsr}}</div>
                                            </div>
                                        {{ /rvar }}
                                        {{ ^rvar }}
                                            <div class="row">
                                                <div class="col-xs-offset-4 col-xs-4">No high impact variants</div>
                                            </div>
                                        {{ /rvar }}

                                    </div>
                                </div>
                            </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div id="burdenGoesHere" class="row"></div>
                </div>
            </div>
       </script>




<script id="commonVariantTemplate"  type="x-tmpl-mustache">
            <div class="row" style="margin-top: 15px;">
                <h3 class="specialTitle">Common variants</h3>
            </div>

            <div class="row">
                <div class="col-lg-12">


                    <div class="row">
                        <div class="col-sm-12">
                         <div class="row variantBoxHeaders" >
                                <div class="col-lg-3">Variant ID</div>

                                <div class="col-lg-3">dbSNP Id</div>

                                <div class="col-lg-2">p-Value</div>

                                <div class="col-lg-1">Effect</div>

                                <div class="col-lg-3">Data set</div>
                            </div>
                            <div class="boxOfVariants">
                                {{ #cvar }}
                                <div class="row {{CAT}}">

                                        <div class="col-lg-3"><a href="${createLink(controller: 'variantInfo', action: 'variantInfo')}/{{id}}" class="boldItlink">{{id}}</a></div>

                                        <div class="col-lg-3"><span class="linkEmulator" onclick="mpgSoftware.geneSignalSummary.refreshLZ('{{id}}','{{dsr}}','{{pname}}','{{pheno}}')" class="boldItlink">{{rsId}}</a></div>

                                        <div class="col-lg-2">{{P_VALUE}}</div>

                                        <div class="col-lg-1">{{BETA}}</div>

                                        <div class="col-lg-3">{{dsr}}</div>

                                </div>
                                {{ /cvar }}
                                {{ ^cvar }}
                                <div class="row">
                                    <div class="col-xs-offset-4 col-xs-4">No common variants</div>
                                </div>
                                {{ /cvar }}
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </script>

<div id="BurdenHiddenHere" style="display:none">
    <g:render template="/widgets/burdenTestShared" model="['variantIdentifier': '',
                                                           'modifiedTitle': 'Run a custom burden test',
                                                           'accordionHeaderClass': 'toned-down-accordion-heading',
                                                           'modifiedTitleStyling': 'font-size: 18px;text-decoration: underline;padding-left: 20px;',
                                                           'modifiedGaitSummary': 'The Genetic Association Interactive Tool (GAIT) allows you to compute the disease or phenotype burden for this gene, using custom sets of variants, samples, and covariates. In order to protect patient privacy, GAIT will only allow visualization or analysis of data from more than 100 individuals.']"/>
</div>


<script>
    var mpgSoftware = mpgSoftware || {};


    (function () {
        "use strict";
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
        mpgSoftware.geneSignalSummary = (function () {
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
                            renderData.variants.push(processAggregatedData(v));
                            //renderData.variants.push(_.forEach(v,procAggregatedData));
                        } else {
                            renderData.variants.push(processAggregatedData(v));
                            //renderData.variants.push(_.forEach(v,procExpandedData));
                        }

                    });
                }
                ;
                return renderData;
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


            var updateAggregateVariantsDisplay = function (data, locToUpdate) {
                var updateHere = $(locToUpdate);
                updateHere.empty();
                if ((data) &&
                        (data.stats)) {
                    updateHere.append("<ul class='aggregateVariantsDescr list-group'>" +
                            "<li class='list-group-item'>" + UTILS.realNumberFormatter(data.stats.beta) + "</li>" +
                            "<li class='list-group-item'>" + UTILS.realNumberFormatter(data.stats.pValue) + "</li>" +
                            "<li class='list-group-item'>" + UTILS.realNumberFormatter(data.stats.ciLower) + " : " + UTILS.realNumberFormatter(data.stats.ciUpper) + "</li>" +
                            "</ul>");
                    if (data.stats.pValue < 0.000001) {
                        updateDisplayBasedOnStoredSignificanceLevel(3);//green light
                    } else if (data.stats.pValue < 0.01) {
                        updateDisplayBasedOnStoredSignificanceLevel(2);//yellow light
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
                    } else {
                        $(otherBtns).css('display','none');
                    }
                }
            };

            var displayInterestingPhenotypes = function (data) {
                var renderData = buildRenderData(data, 0.05);
                var signalLevel = assessSignalSignificance(renderData);
                updateDisplayBasedOnSignificanceLevel(signalLevel);
                var listOfInterestingPhenotypes = buildListOfInterestingPhenotypes(renderData);
                if (listOfInterestingPhenotypes.length > 0) {
                    $('.interestingPhenotypesHolder').css('display','block');
                    var phenotypeDescriptions = '<label>Phenotypes with signals</label>'+
                            '<button type="button" class="btn btn-outline-secondary  btn-sm" style="margin-left: 20px" onclick="mpgSoftware.geneSignalSummary.toggleOtherPhenoBtns()">Additional phenotypes</button>'+
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
                    phenotypeDescriptions += '</ul>';
                    $('#interestingPhenotypes').append(phenotypeDescriptions);

                }
                $('.phenotypeStrength').on("click",function () {
                    var phenocode = $(this).attr('id');
                    var ds = $(this).attr('ds');
                    mpgSoftware.geneSignalSummary.refreshTopVariantsDirectlyByPhenotype(phenocode,
                            mpgSoftware.geneSignalSummary.updateSignificantVariantDisplay,{updateLZ:true,phenotype:phenocode,pname:$(this).text(),ds:ds,preferIgv:true});
                });
                var firstPhenoCode = $('.phenotypeStrength').first().attr('id');
                var firstDS = $('.phenotypeStrength').first().attr('ds');
                var firstPhenoName = $('.phenotypeStrength').first().text();
                mpgSoftware.geneSignalSummary.refreshTopVariantsDirectlyByPhenotype(firstPhenoCode,
                        mpgSoftware.geneSignalSummary.updateSignificantVariantDisplay,{updateLZ:true,phenotype:firstPhenoCode,pname:firstPhenoName,ds:firstDS,preferIgv:true});
            };

                var updateSignificantVariantDisplay = function (data,additionalParameters) {
                    var phenotypeName = additionalParameters.phenotype;
                    var datasetName = additionalParameters.ds;
                    var pName = additionalParameters.pname;
                    var renderData = buildRenderData (data,0.05);
                    var signalLevel = assessSignalSignificance(renderData);
                    var commonSectionShouldComeFirst = commonSectionComesFirst(renderData);
                    renderData = refineRenderData(renderData,1);
                    //updateDisplayBasedOnSignificanceLevel (signalLevel); // The traffic light is now for the gene
                    if (mpgSoftware.locusZoom.plotAlreadyExists()) {
                        mpgSoftware.locusZoom.removeAllPanels();
                    }
                    $('#collapseExample div.well').empty();
                    if (commonSectionShouldComeFirst) {
                        $('#collapseExample div.well').append(
                                        '<div class="text-center" id="phenotypeLabel">'+pName+'</div>'+
                                        '<div id="commonVariantsLocation"></div>' +
                                        '<div id="locusZoomLocation"></div>' +
                                        '<div class="igvGoesHere"></div>'+
                                        '<div id="highImpactVariantsLocation"></div>' +
                                        '<div id="aggregateVariantsLocation"></div>'
                        );
                    } else {
                        $('#collapseExample div.well').append(
                                        '<div class="text-center" id="phenotypeLabel">'+pName+'</div>'+
                                        '<div id="highImpactVariantsLocation"></div>' +
                                        '<div id="aggregateVariantsLocation"></div>' +
                                        '<div id="commonVariantsLocation"></div>'+
                                        '<div id="locusZoomLocation"></div>'+
                                        '<div class="igvGoesHere"></div>');
                    }
                    $("#locusZoomLocation").empty().append(Mustache.render( $('#locusZoomTemplate')[0].innerHTML,renderData));
                    $("#highImpactVariantsLocation").empty().append(Mustache.render( $('#highImpactTemplate')[0].innerHTML,renderData));
                    var tempHtml = $('#BurdenHiddenHere').clone(true).html();
                    if (typeof tempHtml !== 'undefined'){
                        $('#BurdenHiddenHere>dir').empty();
                        $.data(document.body,'burdenText',tempHtml);
                    }
                    tempHtml = $.data(document.body,'burdenText');
                    $('#burdenGoesHere').empty();
                    $(tempHtml).appendTo('#burdenGoesHere');

;
                    $("#aggregateVariantsLocation").empty().append(Mustache.render( $('#aggregateVariantsTemplate')[0].innerHTML,renderData));
                    $("#commonVariantsLocation").empty().append(Mustache.render( $('#commonVariantTemplate')[0].innerHTML,renderData));
                    //var phenotypeName = $('#signalPhenotypeTableChooser option:selected').val();
                    var sampleBasedPhenotypeName = phenotypeNameForSampleData(phenotypeName);
                    var hailPhenotypeInfo = phenotypeNameForHailData(phenotypeName);
                    if ( ( typeof sampleBasedPhenotypeName !== 'undefined') &&
                         ( sampleBasedPhenotypeName.length > 0)) {
                        $('#aggregateVariantsLocation').css('display','block');
                        $('#noAggregatedVariantsLocation').css('display','none');
                        refreshVariantAggregates(sampleBasedPhenotypeName,"0","<%=sampleDataSet%>","<%=burdenDataSet%>","1","1","<%=geneName%>",updateAggregateVariantsDisplay,"#allVariants");
                        refreshVariantAggregates(sampleBasedPhenotypeName,"1","<%=sampleDataSet%>","<%=burdenDataSet%>","1","1","<%=geneName%>",updateAggregateVariantsDisplay,"#allCoding");
                        refreshVariantAggregates(sampleBasedPhenotypeName,"8","<%=sampleDataSet%>","<%=burdenDataSet%>","1","1","<%=geneName%>",updateAggregateVariantsDisplay,"#allMissense")
                        refreshVariantAggregates(sampleBasedPhenotypeName,"7","<%=sampleDataSet%>","<%=burdenDataSet%>","1","1","<%=geneName%>",updateAggregateVariantsDisplay,"#possiblyDamaging");
                        refreshVariantAggregates(sampleBasedPhenotypeName,"6","<%=sampleDataSet%>","<%=burdenDataSet%>","1","1","<%=geneName%>",updateAggregateVariantsDisplay,"#probablyDamaging")
                        refreshVariantAggregates(sampleBasedPhenotypeName,"5","<%=sampleDataSet%>","<%=burdenDataSet%>","1","1","<%=geneName%>",updateAggregateVariantsDisplay,"#proteinTruncating");
                    } else {
                        $('#aggregateVariantsLocation').css('display','none');
                        $('#noAggregatedVariantsLocation').css('display','block');
                    }
                    var positioningInformation = {
                        chromosome: '${geneChromosome}'.replace(/chr/g, ""),
                        startPosition:  ${geneExtentBegin},
                        endPosition:  ${geneExtentEnd}
                    };
                    if (!mpgSoftware.locusZoom.plotAlreadyExists()) {
                        mpgSoftware.locusZoom.initializeLZPage('geneInfo', null, positioningInformation,
                                "#lz-1", "#collapseExample", phenotypeName, pName, '${lzOptions.first().propertyName}', datasetName, 'junk',
                                '${createLink(controller:"gene", action:"getLocusZoom")}',
                                '${createLink(controller:"variantInfo", action:"variantInfo")}', '${lzOptions.first().dataType}');
                    } else {
                        mpgSoftware.locusZoom.resetLZPage('geneInfo', null, positioningInformation,
                                "#lz-1", "#collapseExample", phenotypeName, pName, datasetName, '${lzOptions.first().propertyName}', 'junk',
                                '${createLink(controller:"gene", action:"getLocusZoom")}',
                                '${createLink(controller:"variantInfo", action:"variantInfo")}', '${lzOptions.first().dataType}');
                    }
                    setUpIgv('<%=geneName%>',
                            '.igvGoesHere',
                            "<g:message code='controls.shared.igv.tracks.recomb_rate' />",
                            "<g:message code='controls.shared.igv.tracks.genes' />",
                            "${createLink(controller: 'trait', action: 'retrievePotentialIgvTracks')}",
                            "${createLink(controller:'trait', action:'getData', absolute:'false')}",
                            "${createLink(controller:'variantInfo', action:'variantInfo', absolute:'true')}",
                            "${createLink(controller:'trait', action:'traitInfo', absolute:'true')}",
                            '${igvIntro}');
                    $('#collapseExample').on('shown.bs.collapse', function (e) {
                        mpgSoftware.locusZoom.rescaleSVG();
                    });
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





                        var updateDisplayBasedOnSignificanceLevel = function (significanceLevel) {


                                var significanceLevelDoms = $('.trafficExplanations');

                                            significanceLevelDoms.removeClass('emphasize');
                                            significanceLevelDoms.addClass('unemphasize');


                            $('#trafficLightHolder').empty();
                            var significanceLevelDom = $('.trafficExplanation'+significanceLevel);
                            significanceLevelDom.removeClass('unemphasize');
                            significanceLevelDom.addClass('emphasize');
                            if (significanceLevel == 1){
                                $('#trafficLightHolder').append('<r:img uri="/images/redlight.png"/>');
                            } else if (significanceLevel == 2){
                                $('#trafficLightHolder').append('<r:img uri="/images/yellowlight.png"/>');
                            } else if (significanceLevel == 3){
                                $('#trafficLightHolder').append('<r:img uri="/images/greenlight.png"/>');
                            }
                            $('#signalLevelHolder').text(significanceLevel);
                        };





                        var updateDisplayBasedOnStoredSignificanceLevel = function (newSignificanceLevel) {
                            var currentSignificanceLevel = $('#signalLevelHolder').text();
                            if (newSignificanceLevel>=currentSignificanceLevel){
                                return;
                            }
                            updateDisplayBasedOnSignificanceLevel(newSignificanceLevel);
                        };




                        var refreshVariantAggregates = function (phenotypeName, filterNum, sampleDataSet, dataSet,mafOption, mafValue, geneName, callBack,callBackParameter) {
                            var rememberCallBack = callBack;
                            var rememberCallBackParameter = callBackParameter;

                            $.ajax({
                                cache: false,
                                type: "post",
                                url: "${createLink(controller: 'gene', action: 'burdenTestAjax')}",
                                data: { geneName:geneName,
                                        dataSet:dataSet,
                                        sampleDataSet:sampleDataSet,
                                        filterNum:filterNum,
                                        burdenTraitFilterSelectedOption: phenotypeName,
                                        mafOption:mafOption,
                                        mafValue:mafValue   },
                                async: true,
                                success: function (data) {
                                    rememberCallBack(data,rememberCallBackParameter);
                                },
                                error: function (jqXHR, exception) {
                                    core.errorReporter(jqXHR, exception);
                                }
                            });

                        };

                        var refreshTopVariants = function ( callBack ) {
                            var rememberCallBack = callBack;
                            $.ajax({
                                cache: false,
                                type: "post",
                                url: "${createLink(controller: 'VariantSearch', action: 'retrieveTopVariantsAcrossSgs')}",
                                data: {
                                    geneToSummarize:"${geneName}"},
                                async: true,
                                success: function (data) {
                                    rememberCallBack(data);
                                },
                                error: function (jqXHR, exception) {
                                    core.errorReporter(jqXHR, exception);
                                }
                            });

                        };
                        var refreshTopVariantsDirectlyByPhenotype = function (phenotypeName, callBack, parameter) {
                            var rememberCallBack = callBack;
                            $.ajax({
                                cache: false,
                                type: "post",
                                url: "${createLink(controller: 'VariantSearch', action: 'retrieveTopVariantsAcrossSgs')}",
                                data: {
                                    phenotype: phenotypeName,
                                    geneToSummarize:"${geneName}"},
                                async: true,
                                success: function (data) {
                                    rememberCallBack(data, parameter);
                                },
                                error: function (jqXHR, exception) {
                                    core.errorReporter(jqXHR, exception);
                                }
                            });

                        };
                        var refreshTopVariantsByPhenotype = function (sel, callBack) {
                            var phenotypeName = sel.value;
                            refreshTopVariantsDirectlyByPhenotype(phenotypeName,callBack);
                        };

                var refreshLZ = function(varId,dataSetName,propName,phenotype){
                    var parseId = varId.split("_");
                    var locusZoomRange = 80000;
                    var variantPos = parseInt(parseId[1]);
                    var begPos = 0;
                    var endPos =  variantPos + locusZoomRange;
                    if (variantPos > locusZoomRange ){
                        begPos =  variantPos - locusZoomRange;
                    }
                    var positioningInformation = {
                        chromosome: parseId[0],
                        startPosition: begPos,
                        endPosition: endPos
                    };
                    mpgSoftware.locusZoom.removeAllPanels();


                            %{--mpgSoftware.locusZoom.resetLZPage('geneInfo', null, positioningInformation,--}%
                        %{--"#lz-1","#collapseExample",'T2D','Type 2 Diabetes',dataSetName,propName,phenotype,--}%
                        %{--'${createLink(controller:"gene", action:"getLocusZoom")}',--}%
                        %{--'${createLink(controller:"variantInfo", action:"variantInfo")}','static');--}%
    };




return {
    assessOneSignalsSignificance: assessOneSignalsSignificance,
    updateSignificantVariantDisplay:updateSignificantVariantDisplay,
    displayInterestingPhenotypes:displayInterestingPhenotypes,
    updateDisplayBasedOnSignificanceLevel: updateDisplayBasedOnSignificanceLevel,
    refreshTopVariantsDirectlyByPhenotype:refreshTopVariantsDirectlyByPhenotype,
    refreshTopVariantsByPhenotype:refreshTopVariantsByPhenotype,
    refreshTopVariants:refreshTopVariants,
    toggleOtherPhenoBtns:toggleOtherPhenoBtns,
    refreshLZ:refreshLZ
}
}());


})();
    //
//var loading = $('#spinner').show();
//loading.hide();
$( document ).ready(function() {
    %{--mpgSoftware.geneInfo.fillPhenotypeDropDown('#signalPhenotypeTableChooser',--}%
    %{--'${g.defaultPhenotype()}',--}%
    %{--"${createLink(controller: 'VariantSearch', action: 'retrievePhenotypesAjax')}",--}%
    %{--function(){--}%
    %{--// retrieve the top value in the phenotype drop-down--}%
//    mpgSoftware.geneSignalSummary.refreshTopVariantsDirectlyByPhenotype('T2D',
//    mpgSoftware.geneSignalSummary.updateSignificantVariantDisplay);
    %{--} );--}%
    %{--});--}%

   mpgSoftware.geneSignalSummary.refreshTopVariants(mpgSoftware.geneSignalSummary.displayInterestingPhenotypes);
});


</script>

