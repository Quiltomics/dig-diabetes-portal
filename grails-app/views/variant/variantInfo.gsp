<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="core"/>
    <r:require modules="core"/>
    <r:layoutResources/>
    <%@ page import="dport.RestServerService" %>
    <%
        RestServerService   restServerService = grailsApplication.classLoader.loadClass('dport.RestServerService').newInstance()
    %>
</head>

<body>
<script>
    var variant;
    $.ajax({
        cache:false,
        type:"get",
        url:"../variantAjax/"+"<%=variantToSearch%>",
        async:true,
        success: function (data) {
            fillTheFields(data) ;
            console.log(' fields have been filled')
        }
    });
    function fillTheFields (data)  {
        var cariantRec = {
             _13k_T2D_HET_CARRIERS : 1,
             _13k_T2D_HOM_CARRIERS : 2,
             IN_EXSEQ : 3,
             _13k_T2D_SA_MAF : 4,
             MOST_DEL_SCORE : 5,
             CLOSEST_GENE : 6,
             CHROM : 7,
             Consequence : 8,
             ID : 9,
             _13k_T2D_MINA : 10,
            _13k_T2D_HS_MAF : 11,
            DBSNP_ID : 12,
            _13k_T2D_EA_MAF : 13,
            _13k_T2D_AA_MAF : 14,
            POS : 15,
            _13k_T2D_TRANSCRIPT_ANNOT : 16,
            IN_GWAS : 17,
            GWAS_T2D_PVALUE: 18,
            EXCHP_T2D_P_value: 19,
            _13k_T2D_P_EMMAX_FE_IV: 20
         }
        variant =  data['variant'];
        variantTitle =  UTILS.get_variant_title(variant);
        $('#variantTitle').append(variantTitle);
        $('#variantCharacterization').append(UTILS.getSimpleVariantsEffect(variant.MOST_DEL_SCORE));
        $('#describingVariantAssociation').append(UTILS.variantInfoHeaderSentence(variant));
        var pVal= UTILS.get_lowest_p_value(variant);
        $('#variantPValue').append((parseFloat (pVal[0])).toPrecision(4));
        $('#variantInfoGeneratingDataSet').append(pVal[1]);
        $('#variantInfoGwasSection').append(UTILS.fillAssociationsStatistics(variant,
                cariantRec,
                cariantRec.IN_GWAS,
                cariantRec.GWAS_T2D_PVALUE,
                5e-8,
                5e-2,
                variantTitle,
                "In GWAS data available on this portal,",
                "reaches genome-wide significance for association with T2D",
                "reaches nominal significance for association with T2D",
                "does not reach significance for association with T2D (either genome-wide or nominal)" ,
                "<p>This variant is not in GWAS data available in this portal.</p>"
        ));
        $('#variantInfoExomeChipSection').append(UTILS.fillAssociationsStatistics(variant,
                cariantRec,
                cariantRec.EXCHP_T2D_P_value,
                cariantRec.EXCHP_T2D_P_value,
                5e-8,
                5e-2,
                variantTitle,
                "In exome chip data available on this portal (n&asymp;82,000),",
                "reaches genome-wide significance for association with T2D",
                "reaches nominal significance for association with T2D",
                "does not reach significance for association with T2D (either genome-wide or nominal)" ,
                "<p>This variant is not in exome chip data available in this portal.</p>"
        ));
        $('#variantInfoExomeChipSection').append(UTILS.fillAssociationsStatistics(variant,
                cariantRec,
                cariantRec._13k_T2D_P_EMMAX_FE_IV,
                cariantRec._13k_T2D_P_EMMAX_FE_IV,
                5e-8,
                5e-2,
                variantTitle,
                "In exome data available on this portal (n&asymp;13,000),",
                "reaches genome-wide significance for association with T2D",
                "reaches nominal significance for association with T2D",
                "does not reach significance for association with T2D (either genome-wide or nominal)" ,
                "<p>This variant is not in exome sequencing data available on this portal.</p>"
        ));
        $('#variantInfoAssociationStatisticsLinkToTraitTable').append(UTILS.fillAssociationStatisticsLinkToTraitTable(variant,
                cariantRec,
                cariantRec.IN_GWAS,
                cariantRec.DBSNP_ID,
                cariantRec.ID
        ));
        $('#howCommonInExomeSequencing').append(UTILS.showPercentageAcrossEthnicities(variant));
        $('#howCommonInHeterozygousCarriers').append(UTILS.showPercentagesAcrossHeterozygousCarriers(variant, "<%=variantToSearch%>"));
        $('#howCommonInHomozygousCarriers').append(UTILS.showPercentagesAcrossHomozygousCarriers(variant, "<%=variantToSearch%>"));
        $('#eurocentricVariantCharacterization').append(UTILS.eurocentricVariantCharacterization(variant, "<%=variantToSearch%>"));
        $('#sigmaVariantCharacterization').append(UTILS.sigmaVariantCharacterization(variant, "<%=variantToSearch%>"));
        $('#effectOfVariantOnProtein').append(UTILS.variantGenerateProteinsChooser(variant, "<%=variantToSearch%>"));

    }
</script>


<div id="main">

    <div class="container" >

        <div class="variant-info-container" >
            <div class="variant-info-view" >


                <h1>
                    <span id="variantTitle"></span>
                    <a class="page-nav-link" href="#associations">Associations</a>
                    <a class="page-nav-link" href="#populations">Populations</a>
                    <a class="page-nav-link" href="#biology">Biology</a>
                </h1>

                <g:render template="variantPageHeader" />

                <g:render template="variantAssociationStatistics" />

                <g:render template="howCommonIsVariant" />

                <g:render template="effectOfVariantOnProtein" />

                <g:render template="findOutMore" />

            </div>

        </div>
    </div>

</div>

</body>
</html>

