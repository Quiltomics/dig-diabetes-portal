<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="t2dGenesCore"/>
    <r:require modules="variantInfo, igv"/>
    <r:require modules="tableViewer,traitInfo"/>
    <r:require modules="boxwhisker"/>
    <r:require module="locusZoom"/>
    <r:require modules="core, mustache"/>
    <r:require modules="burdenTest"/>

    <r:layoutResources/>
    <style>
    /* for associations at a glance */
    .smallRow {
        border-top-style: solid;
        border-top-width: 2px;
        border-color: #1fff11;
        margin-top: 10px;
        margin-right: 10px;
        padding: 5px 0px 10px;
    }

    .t2d-info-box-wrapper, .other-traits-info-box-wrapper, #primaryPhenotype {
        padding: 20px 0 0;
    }

    .t2d-info-box-wrapper ul, .other-traits-info-box-wrapper ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .t2d-info-box-wrapper li, .other-traits-info-box-wrapper li {
        display: inline-block;
        vertical-align: top;
    }

    .normal-info-box-holder h3 {
        font-size: 20px;
        line-height: 20px;
        margin-top: 0;
    }

    .normal-info-box-holder > ul > li > h3 {
        font-weight: 400;
    }

    .normal-info-box-holder span.p-value {
        display: block;
        font-size: 18px;
        font-weight: 500;
        margin-bottom: -5px;
    }

    .normal-info-box-holder span.p-value-significance {
        font-size: 11px;
    }

    .normal-info-box-holder span.observation {
        display: block;
        font-size: 14px;
        font-weight: 500;
    }

    .small-info-box-holder {
        margin-top: 10px;
        margin-right: 20px;
        padding: 5px 0 10px;
        border-top: solid 2px; /* color is defined on each item */
    }

    .small-info-box-holder h3 {
        font-size: 14px;
        line-height: 14px;
        font-weight: 600;
        margin-top: 0;
    }

    .small-info-box-holder > ul > li > h3 {
        font-weight: 400;
    }

    /* clear out the margin so the border doesn't have an extra tail */
    .small-info-box-holder > ul > li:nth-last-child(1) {
        margin-right: 0;
    }

    .small-info-box-holder span.p-value {
        display: block;
        font-size: 14px;
        font-weight: 500;
        margin-bottom: -5px;
    }

    .small-info-box-holder span.p-value-significance {
        font-size: 9px;
    }

    .small-info-box-holder span.extra-info {
        font-size: 12px;
    }

    .info-box {
        position: relative;
        margin-right: 10px;
        margin-bottom: 10px;
        padding: 10px;
        text-align: center;
        /* just in case the text isn't otherwise colored */
        color: white;
    }

    .normal-info-box {
        width: 170px;
        height: 170px;
    }

    .small-info-box {
        width: 140px;
        height: 140px;
    }

    .not-significant-box {
        border: solid 1px black;
    }

    .parentsFont {
        font-family: inherit;
        font-weight: inherit;
        font-size: inherit;
    }

    .mbar_xaxis text {
        font-size: 14px;
    }
    </style>


    <link type="application/font-woff">
    <link type="application/vnd.ms-fontobject">
    <link type="application/x-font-ttf">
    <link type="font/opentype">


    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="//oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Google fonts -->
    <link rel="stylesheet" type="text/css" href='//fonts.googleapis.com/css?family=PT+Sans:400,700'>
    <link rel="stylesheet" type="text/css" href='//fonts.googleapis.com/css?family=Open+Sans'>

</head>

<body>
<div id="rSpinner" class="dk-loading-wheel center-block" style="display:none">
    <img src="${resource(dir: 'images', file: 'ajax-loader.gif')}" alt="Loading"/>
</div>
<style>
select.elementTissueSelector{
    margin: 5px 0 10px 0;
}
table.functionDescrTable{
    width: 100%;
    border: 1px inset #4682b4;
    margin: 5px;
}
table.functionDescrTable th {
    font-weight: bold;
    text-decoration: underline;
}
table.functionDescrTable td.elementSpec {
padding-left: 10px;
}
table.functionDescrTable th.elementSpec {
    padding-left: 10px;
}

span.elementTissueSelectorLabel{
    font-weight: bold;
    margin: 0 5px 0 5px;
}
</style>
<script id="functionalAnnotationTemplate"  type="x-tmpl-mustache">
<div class="row">
    <div class="col-xs-5 text-left">
        <span class="elementTissueSelectorLabel">Display element</span><select class="elementTissueSelector uniqueElements" onchange="displayChosenElements()">
        {{#uniqueElements}}
            <option>{{element}}</option>
        {{/uniqueElements}}
        </select>
    </div>
    <div class="col-xs-5 text-left">
        <span class="elementTissueSelectorLabel">Display tissues</span><select class="elementTissueSelector uniqueTissues" onchange="displayChosenElements()">
        {{#uniqueTissues}}
            <option>{{source}}</option>
        {{/uniqueTissues}}
        </select>
    </div>
    <div class="col-xs-2"></div>
 </div>
<div class="row">
    <div class="col-xs-12 text-left">
        <table class='functionDescrTable'>
            {{#recordsExist}}
                <tr class='headers'>
                    <th class='elementSpec' width=35%>Element</th>
                    <th width=35%>Tissue</th>
                    <th width=15%>Start position</th>
                    <th width=15%>End position</th>
                </tr>
            {{/recordsExist}}
            {{#indivRecords}}
                <tr class="elementTissueRows {{element}}__{{source}} {{element}} {{source}}">
                    <td class='elementSpec'>{{element}}</td>
                    <td>{{source}}</td>
                    <td>{{START}}</td>
                    <td>{{STOP}}</td>
                </tr>
            {{/indivRecords}}
            {{^indivRecords}}
            No functional data are available for this variant
            {{/indivRecords}}
        </table>
    </div>
</div>
</script>
<script>
    var displayChosenElements = function (){
        $('table.functionDescrTable tr').hide();
        var chosenElement = $('select.uniqueElements').val();
        var chosenTissue = $('select.uniqueTissues').val();
        var specificCombinationIdentifier = 'table.functionDescrTable tr.'+chosenElement+"__"+chosenTissue;
        if (($(specificCombinationIdentifier).length>0)||
            (chosenElement==='ALL')||
            (chosenTissue==='ALL')){
            $('table.functionDescrTable tr.headers').show();
        }
        if ((chosenElement==='ALL')&&(chosenTissue==='ALL')){
            $('table.functionDescrTable tr').show();
        }
        else if (chosenElement==='ALL'){
            $('table.functionDescrTable tr.'+chosenTissue).show();
        }
        else if (chosenTissue==='ALL'){
            $('table.functionDescrTable tr.'+chosenElement).show();
        } else {
            $('table.functionDescrTable tr.'+chosenElement+"__"+chosenTissue).show();
        }

    };
    // generate the texts here so that the appropriate one can be selected in initializePage
    // the keys (1,2,3,4) map to the assignments for MOST_DEL_SCORE
    var variantSummaryText = {
        1: "${g.message(code: "variant.summaryText.proteinTruncating")}",
        2: "${g.message(code: "variant.summaryText.missense")}",
        3: "${g.message(code: "variant.summaryText.synonymous")}",
        4: "${g.message(code: "variant.summaryText.noncoding")}"
    };

    var displayFunctionalData = function(data,additionalData){
        if ((typeof data !== 'undefined') &&
            (typeof data.variants !== 'undefined') &&
            (!data.variants.is_error)){
            var rawSortedData = _.sortBy(data.variants.variants,[function(item) {
                return item.element;
            }, function(item) {
                return item.source;
            }]);
            var sortedData = [];
            _.forEach(rawSortedData,function(o){
                sortedData.push({'CHROM':o.CHROM,
                'START':o.START,
                'STOP':o.STOP,
                'source':o.source,
                'element':o.element.replace(/[0-9]*/g, '').replace(/^_/,'').replace(/\//,'-')})
            })
            var uniqueElements = _.uniqBy(sortedData,function(item) {
                return item.element;
            });
            uniqueElements.push({element:'ALL'});
            var uniqueTissues = _.uniqBy(sortedData,function(item) {
                return item.source;
            });
            uniqueTissues.push({source:'ALL'});
            var renderData = {  'recordsExist': (sortedData.length>1),
                                'indivRecords':sortedData,
                                'uniqueElements':uniqueElements,
                                'uniqueTissues':uniqueTissues};
            $("#functionalDateGoesHere").empty().append(Mustache.render( $('#functionalAnnotationTemplate')[0].innerHTML,renderData));
            $('select.uniqueElements').val('ALL');
            $('select.uniqueTissues').val('ALL');
        }
    };

    var loading = $('#spinner').show();
    // sometimes the headers weren't fully loaded before the initializePage function was called,
    // so don't run it until the DOM is ready
    $(document).ready(function () {
        $.ajax({
            cache: false,
            type: "get",
            url: ('<g:createLink controller="variantInfo" action="variantAjax"/>' + '/${variantToSearch}'),
            async: true
        }).done(function (data, textStatus, jqXHR) {

                mpgSoftware.variantInfo.initializePage(data,
                    "<%=variantToSearch%>",
                    "<g:createLink controller='trait' action='traitInfo' />",
                    "<%=restServer%>",
                    variantSummaryText,
                    'stroke',"#lz-47","#collapseLZ",'${lzOptions.first().key}','${lzOptions.first().description}','${lzOptions.first().propertyName}','${lzOptions.first().dataSet}',
                        '${createLink(controller:"gene", action:"getLocusZoom")}',
                    '${createLink(controller:"variantInfo", action:"variantInfo")}','${lzOptions.first().dataType}');
                mpgSoftware.variantInfo.retrieveFunctionalData(data,displayFunctionalData,
                    {retrieveFunctionalDataAjaxUrl:'${createLink(controller:"variantInfo", action:"retrieveFunctionalDataAjax")}'});


        }).fail(function (jqXHR, textStatus, errorThrown) {
            loading.hide();
            core.errorReporter(jqXHR, errorThrown)
        });
    });
</script>


<div id="main">

    <div class="container">

        <div class="variant-info-container">
            <div class="variant-info-view">

                <h1>
                    <strong><span id="variantTitle" class="parentsFont"></span> summary</strong>
                </h1>

                <g:render template="variantPageHeader"/>



                <div class="accordion" id="accordionVariant">

                    <div class="accordion-group">
                        <div class="accordion-heading">
                            <a class="accordion-toggle" data-toggle="collapse"
                               data-parent="#accordionVariant"
                               href="#collapseFunctionalData">
                                <h2><strong>Epigenetic data</strong></h2>
                            </a>
                        </div>

                        <div id="collapseFunctionalData" class="accordion-body collapse">
                            <div class="accordion-inner">
                                <div id="functionalDateGoesHere"></div>
                            </div>
                        </div>
                    </div>



                    <div class="accordion-group">
                        <div class="accordion-heading">
                            <a class="accordion-toggle" data-toggle="collapse"
                               data-parent="#accordionVariant"
                               href="#collapseVariantAssociationStatistics">
                                <h2><strong><g:message code="variant.variantAssociationStatistics.title"
                                                       default="Variant associations at a glance"/></strong></h2>
                            </a>
                        </div>

                        <div id="collapseVariantAssociationStatistics" class="accordion-body collapse">
                            <div class="accordion-inner">
                                <g:render template="variantAssociationStatistics"/>
                            </div>
                        </div>
                    </div>

                    <div class="separator"></div>

                    <g:render template="/widgets/associatedStatisticsTraitsPerVariant"
                              model="[variantIdentifier: variantToSearch, locale: locale]"/>


                <g:if test="${g.portalTypeString()?.equals('stroke')||
                        g.portalTypeString()?.equals('t2d')||

                        g.portalTypeString()?.equals('mi')}">

                        <div class="separator"></div>

                    <g:render template="/templates/burdenTestSharedTemplate" model="['variantIdentifier': variantToSearch, 'accordionHeaderClass': 'accordion-heading']"/>
                    <g:render template="/widgets/burdenTestShared" model="['variantIdentifier': variantToSearch, 'accordionHeaderClass': 'accordion-heading']"/>

                    </g:if>


                    <div class="separator"></div>

                    <g:if test="${true}">
                        <g:render template="/widgets/locusZoomPlot"/>

                        <div class="separator"></div>

                    </g:if>

                    <div class="accordion-group">
                        <div class="accordion-heading">
                            <a class="accordion-toggle  collapsed" data-toggle="collapse"
                               data-parent="#accordionVariant"
                               href="#collapseHowCommonIsVariant">
                                <h2><strong><g:message code="variant.howCommonIsVariant.title"
                                                       default="How common is variant"/></strong></h2>
                            </a>
                        </div>

                        <g:render template="howCommonIsVariant"/>

                    </div>

                    <g:renderBetaFeaturesDisplayedValue>
                    <div class="separator"></div>

                    <div class="accordion-group">
                    <div class="accordion-heading">
                    <a class="accordion-toggle  collapsed" data-toggle="collapse"
                    data-parent="#accordionVariant"
                    href="#collapseCarrierStatusImpact">
                    <h2><strong><g:message code="variant.carrierStatusImpact.title" default="How many carriers in the data set"/></strong></h2>
                    </a>
                    </div>

                    <g:render template="carrierStatusImpact"/>

                    </div>

                    </g:renderBetaFeaturesDisplayedValue>

                    <div class="separator"></div>

                    <div class="accordion-group">
                        <div class="accordion-heading">
                            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordionVariant"
                               href="#collapseIgv">
                                <h2><strong><g:message code="variant.igvBrowser.title"
                                                       default="Explore with IGV"/></strong></h2>
                            </a>
                        </div>

                        <div id="collapseIgv" class="accordion-body collapse">
                            <div class="accordion-inner">
                                <div class="igvGoesHere"></div>
                                <g:render template="../templates/igvBrowserTemplate"/>
                            </div>
                        </div>
                    </div>

                    <div class="separator"></div>

                    <div class="accordion-group">
                        <div class="accordion-heading">
                            <a class="accordion-toggle  collapsed" data-toggle="collapse"
                               data-parent="#accordionVariant"
                               href="#collapseFindOutMore">
                                <h2><strong><g:message code="variant.findOutMore.title"
                                                       default="find out more"/></strong></h2>
                            </a>
                        </div>

                        <div id="collapseFindOutMore" class="accordion-body collapse">
                            <div class="accordion-inner">
                                <g:render template="findOutMore"/>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </div>

</div>
<script>
    $('#accordionVariant').on('shown.bs.collapse', function (e) {
        if (e.target.id === "collapseIgv") {
            var igvParms = mpgSoftware.variantInfo.retrieveVariantPosition();
           igvLauncher.setUpIgv(igvParms.locus,
                    '.igvGoesHere',
                    "<g:message code='controls.shared.igv.tracks.recomb_rate' />",
                    "<g:message code='controls.shared.igv.tracks.genes' />",
                    "${createLink(controller: 'trait', action: 'retrievePotentialIgvTracks')}",
                    "${createLink(controller:'trait', action:'getData', absolute:'false')}",
                    "${createLink(controller:'variantInfo', action:'variantInfo', absolute:'true')}",
                    "${createLink(controller:'trait', action:'traitInfo', absolute:'true')}",
                    '${igvIntro}');
        }

    });
    $('#accordionVariant').on('show.bs.collapse', function (e) {
        if (e.target.id === "collapseIgv") {

        }
    });

    $('#collapseVariantAssociationStatistics').collapse({hide: false})
</script>

</body>
</html>

