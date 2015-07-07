<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="t2dGenesCore"/>
    <r:require modules="core"/>
    <r:require modules="tableViewer"/>
    <r:layoutResources/>
</head>

<body>
<script>
    var regionSpec = "<%=regionSpecification%>";
    jQuery.fn.dataTableExt.oSort['allnumeric-asc']  = function(a,b) {
        var x = parseFloat(a);
        var y = parseFloat(b);
        if (!x) { x = 1; }
        if (!y) { y = 1; }
        return ((x < y) ? -1 : ((x > y) ?  1 : 0));
    };

    jQuery.fn.dataTableExt.oSort['allnumeric-desc']  = function(a,b) {
        var x = parseFloat(a);
        var y = parseFloat(b);
        if (!x) { x = 1; }
        if (!y) { y = 1; }
        return ((x < y) ? 1 : ((x > y) ?  -1 : 0));
    };
    var loading = $('#spinner').show();
    $.ajax({
        cache:false,
        type:"get",
        url:"../regionAjax/"+regionSpec,
        async:true,
        success: function (data) {
            fillTheFields(data) ;
            loading.hide();
        },
        error: function(jqXHR, exception) {
            loading.hide();
            core.errorReporter(jqXHR, exception) ;
        }
    });
    var  proteinEffectList =  new UTILS.proteinEffectListConstructor (decodeURIComponent("${proteinEffectsList}")) ;
    function fillTheFields (data)  {
        variantProcessing.oldIterativeVariantTableFiller(data,'#variantTable',
                ${show_gene},
                ${show_exseq},
                ${show_exchp},
                '<g:createLink controller="variantInfo" action="variantInfo" />',
                '<g:createLink controller="gene" action="geneInfo" />',
                proteinEffectList);

    }


</script>


<div id="main">

    <div class="container" >

        <div class="variant-info-container" >
            <div class="variant-info-view" >

                <g:render template="geneSummaryForRegion" />

                <g:render template="collectedVariantsForRegion" />

            </div>

        </div>
    </div>

</div>

</body>
</html>

