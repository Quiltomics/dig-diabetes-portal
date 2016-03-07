var mpgSoftware = mpgSoftware || {};


(function () {
    "use strict";


    mpgSoftware.trait = (function () {

        var fillTheTraitsPerVariantFields = function  (data,
                                                       traitsPerVariantTableBody,
                                                       traitsPerVariantTable,
                                                       showGene,
                                                       showExomeSequence,
                                                       showExomeChip,
                                                       traitUrl,
                                                       locale,
                                                       copyText,
                                                       printText)  {
            var variant =  data['traitInfo'];
            $('[data-toggle="tooltip"]').tooltip({container: 'body'});
            var languageSetting = {}
            // check if the browser is using Spanish
            if ( locale.startsWith("es")  ) {
                languageSetting = { url : '../../js/lib/i18n/table.es.json' }
            }

            var table = $(traitsPerVariantTable).dataTable({
                iDisplayLength: 250,
                bFilter: false,
                bPaginate: false,
                aaSorting: [[ 1, "asc" ]],
                sDom: '<"top">rt<"bottom"flp><"clear">',
                aoColumnDefs: [
                    { sType: "stringAnchor", aTargets: [ 1 ] },
                    { sType: "headerAnchor", aTargets: [0] },
                    { "bSortable": false, "aTargets": [0,2,3,4,5,6] },
                    { "width": "80px", "aTargets": [ 4,5,6 ] },
                    { "width": "90px", "aTargets": [ 3 ] },
                    { "width": "100px", "aTargets": [ 2 ] }],
                headerCallback: function( thead, data, start, end, display ) {
                    if (data.length===0){
                        var label0 = $(thead).find('th').eq(0).html();
                        var label1 = $(thead).find('th').eq(1).html();
                        var label2 = $(thead).find('th').eq(2).html();
                        $(thead).find('th').eq(2).html( label2+'<div style="font-size:9px">highlight if p < 0.05</div>');
                    }
                },
                createdRow: function ( row, data, index ) {
                    var rowPtr = $(row);
                    var convertedSampleGroup = $(data[0]).attr('convertedSampleGroup');
                    var cells = rowPtr.children();
                    if (cells.length > 0){ // ignore headers
                        $(cells[0]).addClass('vandaRowTd');
                        var pValue = $(cells[2]).text();
                        if ((typeof pValue !== 'undefined')  &&
                            (pValue !== "" )){
                            var pValueNumber = parseFloat(pValue);
                            if ( !isNaN(pValueNumber) ){
                                if ( pValueNumber <= 0.05 ) {
                                    $(cells[2]).addClass('significantPValue');
                                }
                            }
                        }
                    }
                    if ($(data[0]).hasClass('indexRow')){
                        var rowsPerPhenotype = parseInt($(data[0]).attr('rowsPerPhenotype'));
                        rowPtr.attr('id',$(data[0]).attr('phenotypename'));
                        rowPtr.attr('class','clickable');
                        rowPtr.attr('data-toggle','collapse');
                        rowPtr.attr('data-target',"."+$(data[0]).attr('phenotypename')+"collapsed");
                        rowPtr.attr('id',$(data[0]).attr('phenotypename'));
                        if (rowsPerPhenotype>1) {
                            if (convertedSampleGroup.indexOf(':')===-1) {
                                $(rowPtr.children()[1]).append("<div class='glyphicon glyphicon-plus-sign pull-right' aria-hidden='true' data-toggle='tooltip' "+
                                    "data-placement='right' title='Click to open additional associations for "+convertedSampleGroup+" across other data sets' onclick='respondToPlusSignClick(this)'></div>");
                            }
                        }
                     } else {
                        if (convertedSampleGroup.indexOf(':')===-1) { // non cohort may be collapsed
                            rowPtr.attr('class',"collapse out "+$(data[0]).attr('phenotypename')+"collapsed");
                        } else { // cohort data was requested specifically -- don't collapse it
                            rowPtr.attr('class',"collapse in "+$(data[0]).attr('phenotypename')+"collapsed");
                        }

                    }
                },
                language: languageSetting
            });
            var tableTools = new $.fn.dataTable.TableTools( table, {
                "aButtons": [
                    { "sExtends": "copy", "sButtonText": copyText },
                    "csv",
                    "xls",
                    "pdf",
                    { "sExtends": "print", "sButtonText": printText }
                ],
                "sSwfPath": "../../js/DataTables-1.10.7/extensions/TableTools/swf/copy_csv_xls_pdf.swf"
            } );
            variantProcessing.addTraitsPerVariantTable(variant,
                traitsPerVariantTable,
                traitUrl,0);
        };


        var addMoreTraitsPerVariantFields = function  (data,
                                                       traitsPerVariantTableBody,
                                                       traitsPerVariantTable,
                                                       showGene,
                                                       showExomeSequence,
                                                       showExomeChip,
                                                       traitUrl,
                                                       locale,
                                                       copyText,
                                                       printText,
                                                       existingRows)  {
            var variant =  data['traitInfo'];
            variantProcessing.addTraitsPerVariantTable(variant,
                traitsPerVariantTable,
                traitUrl,
                existingRows);
        };



        var getDbSnpId = function (data) {
            var dbSnpId;

            if ((typeof data !== 'undefined') &&
                (typeof data.results !== 'undefined')  &&
                (typeof data.results[0] !== 'undefined')  &&
                (typeof data.results[0]["pVals"] !== 'undefined')  &&
                (data.results[0]["pVals"].length > 0) ) {

                // loop through and find the 'DBSNP_ID' level key to get the dbSnpId
                for ( var i = 0 ; i < data.results[0]["pVals"].length ; i++ ) {
                    var key = data.results[0]["pVals"][i].level;
                    if (key === 'DBSNP_ID') {
                        dbSnpId = data.results[0]["pVals"][i].count;
                        // alert('DB SNP is: ' + dbSnpId);
                        break;
                    }
                }
            }

            return dbSnpId;
        };

        return {
            // private routines MADE PUBLIC FOR UNIT TESTING ONLY (find a way to do this in test mode only)
            fillTheTraitsPerVariantFields: fillTheTraitsPerVariantFields,
            addMoreTraitsPerVariantFields:addMoreTraitsPerVariantFields,
            getDbSnpId: getDbSnpId
        }


    }());

})();

