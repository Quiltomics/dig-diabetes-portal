<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="core"/>
    <r:require modules="core"/>
    <r:require modules="geneInfo"/>
    <r:layoutResources/>
    <%@ page import="dport.RestServerService" %>

    <link type="application/font-woff">
    <link type="application/vnd.ms-fontobject">
    <link type="application/x-font-ttf">
    <link type="font/opentype">

    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" type="text/css"
          rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="//oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Bootstrap -->
    <g:javascript src="lib/igv/vendor/inflate.js"/>
    <g:javascript src="lib/igv/vendor/zlib_and_gzip.min.js"/>

    <!-- IGV js  and css code -->
    <link href="http://www.broadinstitute.org/igvdata/t2d/igv.css" type="text/css" rel="stylesheet">
    %{--<g:javascript base="http://iwww.broadinstitute.org/" src="/igvdata/t2d/igv-all.js" />--}%
    <g:javascript base="http://www.broadinstitute.org/" src="/igvdata/t2d/igv-all.min.js"/>
    <g:set var="restServer" bean="restServerService"/>
</head>

<body>
<script>
    var loading = $('#spinner').show();
    $.ajax({
        cache: false,
        type: "post",
        url: "../geneInfoAjax",
        data: {geneName: '<%=geneName%>'},
        async: true,
        success: function (data) {
            fillTheGeneFields(data,
                    ${show_gwas},
                    ${show_exchp},
                    ${show_exseq},
                    ${show_sigma},
                    '<g:createLink controller="region" action="regionInfo" />',
                    '<g:createLink controller="trait" action="traitSearch" />',
                    '<g:createLink controller="variantSearch" action="gene" />');
            loading.hide();
        },
        error: function (jqXHR, exception) {
            loading.hide();
            core.errorReporter(jqXHR, exception);
        }
    });
    var phenotype = new UTILS.phenotypeListConstructor(decodeURIComponent("${phenotypeList}"));
</script>

<div id="main">

<div class="container">

<div class="gene-info-container">
<div class="gene-info-view">

<h1>
    <em><%=geneName%></em>
</h1>



<g:if test="${(geneName == "C19ORF80") ||
        (geneName == "PAM") ||
        (geneName == "HNF1A") ||
        (geneName == "SLC16A11") ||
        (geneName == "SLC30A8") ||
        (geneName == "WFS1")}">
    <div class="gene-summary">
        <div class="title">Curated Summary</div>

        <div id="geneHolderTop" class="top">
            <script>
                var contents = '<g:renderGeneSummary geneFile="${geneName}-top"></g:renderGeneSummary>';
                $('#geneHolderTop').html(contents);
            </script>

        </div>

        <div class="bottom ishidden" id="geneHolderBottom" style="display: none;">
            <script>
                var contents = '<g:renderGeneSummary geneFile="${geneName}-bottom"></g:renderGeneSummary>';
                $('#geneHolderBottom').html(contents);
                function toggleGeneDescr() {
                    if ($('#geneHolderBottom').is(':visible')) {
                        $('#geneHolderBottom').hide();
                        $('#gene-summary-expand').html('click to expand');
                    } else {
                        $('#geneHolderBottom').show();
                        $('#gene-summary-expand').html('click to collapse');
                    }
                }
            </script>

        </div>
        <a class="boldlink" id="gene-summary-expand" onclick="toggleGeneDescr()">click to expand</a>
    </div>
</g:if>

<p><span id="uniprotSummaryGoesHere"></span></p>


<div class="accordion" id="accordion2">
    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion2"
               href="#collapseOne">
                <h2><strong><g:message code="gene.variantassociations.title" default="Variants and associations"/></strong></h2>
            </a>
        </div>

        <div id="collapseOne" class="accordion-body collapse in">
            <div class="accordion-inner">
                <g:render template="variantsAndAssociations"/>
            </div>
        </div>
    </div>

    <div class="separator"></div>

    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion2"
               href="#collapseIgv">
                <h2><strong>Explore significant variants with IGV</strong></h2>
            </a>
        </div>

        <div id="collapseIgv" class="accordion-body collapse">
            <div class="accordion-inner">
                <g:render template="../trait/igvBrowser"/>
            </div>
        </div>
    </div>

    <script>
        $('#accordion2').on('shown.bs.collapse', function (e) {
            if (e.target.id === "collapseIgv") {
 <g:renderSigmaSection>
                igvLauncher.launch("#myDiv", "${geneName}","${restServer.currentRestServer()}",[1,0,0,1]);
 </g:renderSigmaSection>
 <g:renderNotSigmaSection>
                igvLauncher.launch("#myDiv", "${geneName}","${restServer.currentRestServer()}",[1,1,1,0]);
 </g:renderNotSigmaSection>

            }

        });
        $('#accordion2').on('show.bs.collapse', function (e) {
            if (e.target.id === "collapseThree") {
                if ((typeof delayedDataPresentation !== 'undefined') &&
                        (typeof delayedDataPresentation.launch !== 'undefined')) {
                    delayedDataPresentation.launch();
                }
            }
        });
        $('#accordion2').on('hide.bs.collapse', function (e) {
            if (e.target.id === "collapseThree") {
                if ((typeof delayedDataPresentation !== 'undefined') &&
                        (typeof delayedDataPresentation.launch !== 'undefined')) {
                    delayedDataPresentation.removeBarchart();
                }
            }
        });
        $('#collapseOne').collapse({hide: true})
    </script>

    <g:if test="${show_exseq}">

    <div class="separator"></div>

    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle  collapsed" data-toggle="collapse" data-parent="#accordion2"
               href="#collapseTwo">
                <h2><strong>Variation across continental ancestry groups</strong></h2>
            </a>
        </div>

        <div id="collapseTwo" class="accordion-body collapse">
            <div class="accordion-inner">
                <g:render template="variationAcrossContinents"/>
            </div>
        </div>
    </div>

    </g:if>

<g:if test="${show_exseq || show_sigma}">

    <div class="separator"></div>

    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle  collapsed" data-toggle="collapse" data-parent="#accordion2"
               href="#collapseThree">
                <h2><strong>Biological hypothesis testing</strong></h2>
            </a>
        </div>

        <div id="collapseThree" class="accordion-body collapse">
            <div class="accordion-inner">
                <g:render template="biologicalHypothesisTesting"/>
            </div>
        </div>
    </div>

</g:if>

    <div class="separator"></div>

    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle  collapsed" data-toggle="collapse" data-parent="#accordion2"
               href="#findOutMore">
                <h2><strong>Find out more</strong></h2>
            </a>
        </div>

        <div id="findOutMore" class="accordion-body collapse">
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

</body>
</html>

