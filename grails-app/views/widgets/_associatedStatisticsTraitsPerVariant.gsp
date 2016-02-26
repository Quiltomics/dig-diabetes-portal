<!-- inputs needed
    variantIdentifier: the variant id
    dbSnpId: for the snp id, if provided (from the trait info page)
    openOnLoad: if accordion closed at start
-->

<style>
tr.collapse.in {
    display: table-row;
}
tr.bestAssociation {

}

tr.otherAssociations {
    display: none;
}

div.sgIdentifierInTraitTable {
    text-align: left;
}

button.expandoButton {
    background-color: rgba(217, 246, 253, 0.51);
    font-size: 10px;
}

button.expandoButton:hover {
    color: black;
}

button.expandoButton:active {
    color: white;
}

button.expandoButton:visited {
    color: white;
}

#collapseVariantTraitAssociation th {
    vertical-align: middle;
}
</style>


<div class="accordion-group">
<div class="accordion-heading">
    <a class="accordion-toggle  collapsed" data-toggle="collapse" href="#collapseVariantTraitAssociation">
        <h2><strong><g:message code="widgets.variant.trait.associations.title"
                               default="Association statistics across 25 traits"/><g:if test="${dnSnpId}"><g:message
                code="site.shared.phrases.for"/> ${dnSnpId}</g:if></strong></h2>
    </a>
</div>


<div id="collapseVariantTraitAssociation" class="accordion-body collapse">
    <div class="accordion-inner" id="traitAssociationInner">

    <r:require modules="core"/>
    <r:require modules="tableViewer,traitInfo"/>

    <script>
        var mpgSoftware = mpgSoftware || {};

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
            return str1.localeCompare(str2);
        };


        // track if data table loaded yet; get reinitialization error
        var tableNotLoaded = true;
        var maximumDataSetsPerCall = 40;
        var dbSnpId;
        var sortingColumn = 0;
        var allowExpansionByCohort = function () {
            sortingColumn = 0;
            $('.jstree-ocl').show();
            $('div.glyphicon').hide();
        };
        var allowExpansionByTrait = function () {
            sortingColumn = 1;
            $('.jstree-ocl').show();
            $('div.glyphicon').hideshow();
        };
        var respondToPlusSignClick = function (drivingDom) {
            var jqueryElement = $(drivingDom);
            if (jqueryElement.hasClass('glyphicon-plus-sign')){
                jqueryElement.removeClass('glyphicon-plus-sign') ;
                jqueryElement.addClass('glyphicon-minus-sign') ;
                jqueryElement.attr('title',"Click to remove additional associations for GIANT GWAS across other data sets");
            } else if (jqueryElement.hasClass('glyphicon-minus-sign')) {
                jqueryElement.addClass('glyphicon-plus-sign') ;
                jqueryElement.removeClass('glyphicon-minus-sign') ;
                jqueryElement.attr('title',"Click to open additional associations for GIANT GWAS across other data sets");
            }
        };

        mpgSoftware.widgets = (function () {
            var loadAssociationTable = function () {
                var variant;
                var loading = $('#spinner').show();
                $.ajax({
                    cache: false,
                    type: "get",
                    url: '<g:createLink controller="trait" action="ajaxAssociatedStatisticsTraitPerVariant" />',
                    data: {variantIdentifier: '<%=variantIdentifier%>',
                        technology: ''},
                    async: true,
                    success: function (data) {
                        mpgSoftware.trait.fillTheTraitsPerVariantFields(data,
                                '#traitsPerVariantTableBody',
                                '#traitsPerVariantTable',
                                data['show_gene'],
                                data['show_exseq'],
                                data['show_exchp'],
                                '<g:createLink controller="trait" action="traitSearch" />',
                                "${locale}",
                                '<g:message code="table.buttons.copyText" default="Copy" />',
                                '<g:message code="table.buttons.printText" default="Print me!" />');
                        var sgLinks = $('.sgIdentifierInTraitTable');

                        for (var i = 0; i < sgLinks.length; i++) {
                            var jqueryObj = $(sgLinks[i]);
                            UTILS.jsTreeDataRetriever('#' + jqueryObj.attr('id'), '#traitsPerVariantTable',
                                    jqueryObj.attr('phenotypename'),
                                    jqueryObj.attr('datasetname'),
                                    "${createLink(controller: 'VariantSearch', action: 'retrieveJSTreeAjax')}");
                        }

                        loading.hide();
                    },
                    error: function (jqXHR, exception) {
                        loading.hide();
                        core.errorReporter(jqXHR, exception);
                    }
                });
            };

            return {loadAssociationTable: loadAssociationTable}
        }());

        $("#collapseVariantTraitAssociation").on("show.bs.collapse", function () {
            if (tableNotLoaded) {
                mpgSoftware.widgets.loadAssociationTable();
                tableNotLoaded = false;
            }
        });
        $('#traitsPerVariantTable').on('order.dt', UTILS.labelIndenter('traitsPerVariantTable'));


        var traitTable = function (variantIdentifier, datasetmaps) {

            var addMoreValues = function (data, howManyGroups) {
                if (howManyGroups == 0) {
                    mpgSoftware.trait.fillTheTraitsPerVariantFields(data,
                            '#traitsPerVariantTableBody',
                            '#traitsPerVariantTable',
                            data['show_gene'],
                            data['show_exseq'],
                            data['show_exchp'],
                            '<g:createLink controller="trait" action="traitSearch" />',
                            "${locale}",
                            '<g:message code="table.buttons.copyText" default="Copy" />',
                            '<g:message code="table.buttons.printText" default="Print me!" />');
                } else {
                    mpgSoftware.trait.addMoreTraitsPerVariantFields(data,
                            '#traitsPerVariantTableBody',
                            '#traitsPerVariantTable',
                            data['show_gene'],
                            data['show_exseq'],
                            data['show_exchp'],
                            '<g:createLink controller="trait" action="traitSearch" />',
                            "${locale}",
                            '<g:message code="table.buttons.copyText" default="Copy" />',
                            '<g:message code="table.buttons.printText" default="Print me!" />',
                                    howManyGroups * maximumDataSetsPerCall);
                }
                var sgLinks = $('.sgIdentifierInTraitTable');

                for (var i = 0; i < sgLinks.length; i++) {
                    var jqueryObj = $(sgLinks[i]);
                    UTILS.jsTreeDataRetriever('#' + jqueryObj.attr('id'), '#traitsPerVariantTable',
                            jqueryObj.attr('phenotypename'),
                            jqueryObj.attr('datasetname'),
                            "${createLink(controller: 'VariantSearch', action: 'retrieveJSTreeAjax')}");
                }
            };


            var loading = $('#spinner').show();
            var jsonString = "";
            // workaround necessary because we can't have too many joins in a single request.  The goal is to
            //  fix this problem on the backend, but between now and then here is a trick we can use
            var numberOfTopLevelLoops = Math.floor(datasetmaps.length / maximumDataSetsPerCall);
            for (var dataSetGroupCount = 0; dataSetGroupCount < numberOfTopLevelLoops + 1; dataSetGroupCount++) {
                var dataSetCount = 0;
                var rowMap = [];
                var rowValues = [];
                while ((dataSetCount < maximumDataSetsPerCall) &&
                        (((maximumDataSetsPerCall * dataSetGroupCount) + dataSetCount) < datasetmaps.length)) {
                    rowMap.push(datasetmaps[(maximumDataSetsPerCall * dataSetGroupCount) + dataSetCount]);
                    dataSetCount++;
                }
                if ((typeof rowMap !== 'undefined') &&
                        (rowMap)) {
                    rowMap.map(function (d) {
                        rowValues.push("{\"ds\":\"" + d.name + "\",\"prop\":\"" + d.pvalue + "\",\"phenotype\":\"" + d.phenotype + "\"}");
                    });
                    jsonString = "{\"vals\":[\n" + rowValues.join(",\n") + "\n]}";

                }
                $.ajax({
                    cache: false,
                    type: "get",
                    url: '<g:createLink controller="trait" action="ajaxSpecifiedAssociationStatisticsTraitsPerVariant" />',
                    data: { variantIdentifier: variantIdentifier,
                        technology: '',
                        chosendataData: jsonString },
                    // datasetmaps:datasetmaps },
                    async: false,
                    success: function (data) {
                        var firstTime = (dataSetGroupCount == 0);
                        if (firstTime) {
                            if ($.fn.DataTable.isDataTable('#traitsPerVariantTable')) {
                                $('#traitsPerVariantTable').dataTable({"bRetrieve": true}).fnDestroy();
                            }

                            $('#traitsPerVariantTable').empty();
                            $('#traitsPerVariantTable').append('<thead>' +
                                    '<tr>' +
                                    '<th><g:message code="variantTable.columnHeaders.shared.dataSet" /></th>' +
                                    '<th><g:message code="informational.shared.header.trait" /></th>' +
                                    '<th><g:message code="variantTable.columnHeaders.sigma.pValue" /></th>' +
                                    '<th><g:message code="variantTable.columnHeaders.shared.direction" /></th>' +
                                    '<th><g:message code="variantTable.columnHeaders.shared.oddsRatio" /></th>' +
                                    '<th><g:message code="variantTable.columnHeaders.shared.maf" /></th>' +
                                    '<th><g:message code="variantTable.columnHeaders.shared.effect" /></th>' +
                                    '</tr>' +
                                    '</thead>');
                            $('#traitsPerVariantTable').append('<tbody id="traitsPerVariantTableBody">' +
                                    '</tbody>');
                        }
                        addMoreValues(data, dataSetGroupCount);
                        loading.hide();
                    },
                    error: function (jqXHR, exception) {
                        loading.hide();
                        core.errorReporter(jqXHR, exception);
                    }
                });
            }

        };


        function reviseTraitsTableRows() {

            var clickedBoxes = $('#traitsPerVariantTable .jstree-clicked');
            var dataSetNames = [];
            var dataSetMaps = [];
            for (var i = 0; i < clickedBoxes.length; i++) {
                var comboName = $(clickedBoxes[i]).attr('id');
                var partsOfCombo = comboName.split("-");
                var dataSetWithoutAnchor = partsOfCombo[0];
                dataSetNames.push(dataSetWithoutAnchor);
                var dataSetMap = {"name": dataSetWithoutAnchor,
                    "value": dataSetWithoutAnchor,
                    "pvalue": partsOfCombo[1],
                    "phenotype": partsOfCombo[3].substring(0, partsOfCombo[3].length - 7)};
                dataSetMaps.push(dataSetMap);
            }


            traitTable('<%=variantIdentifier%>', dataSetMaps);
        }


    </script>


    <div class="gwas-table-container">
        <table id="traitsPerVariantTable" class="table basictable gwas-table">

            <thead>
            <tr>
                <th><g:message code="variantTable.columnHeaders.shared.dataSet"/></th>
                <th><g:message code="informational.shared.header.trait"/></th>
                <th><g:message code="variantTable.columnHeaders.sigma.pValue"/></th>
                <th><g:message code="variantTable.columnHeaders.shared.direction"/></th>
                <th><g:message code="variantTable.columnHeaders.shared.oddsRatio"/></th>
                <th><g:message code="variantTable.columnHeaders.shared.maf"/></th>
                <th><g:message code="variantTable.columnHeaders.shared.effect"/></th>
            </tr>
            </thead>
            <tbody id="traitsPerVariantTableBody">
            </tbody>
        </table>
    </div>
    <div class="row clearfix">
        <div class="col-md-2">
            <div class="pull-left" style="margin: 0 0 0 0">
                <button id="reviser" class="btn btn-primary pull-left" onclick="reviseTraitsTableRows()">
                    <g:message code="gene.variantassociations.change.rows" default="Revise rows"/>
                </button>
            </div>

        </div>
        <div class="col-md-10"></div>
    </div>


    </div>
</div>


<g:if test="${openOnLoad}">
    <script>
        $('#collapseVariantTraitAssociation').collapse({hide: false})
    </script>
</g:if>
