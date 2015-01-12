//beforeEach(function () {
//  jasmine.addMatchers({
//    toBePlaying: function () {
//      return {
//        compare: function (actual, expected) {
//          var player = actual;
//
//          return {
//            pass: player.currentlyPlayingSong === expected && player.isPlaying
//          }
//        }
//      };
//    }
//  });
//});


describe("expandRegionBegin", function() {
    it("expands beginning region, start  > 500000, by 500000", function() {
        expect(mpgSoftware.geneInfo.expandRegionBegin(500000 * 2)).toEqual(500000);
    });
    it("region < 500000 defaults to 0", function() {
        expect(mpgSoftware.geneInfo.expandRegionBegin(499999)).toEqual(0);
    });
    it("null argument", function() {
        expect(mpgSoftware.geneInfo.expandRegionBegin()).toEqual(0);
    });

});

describe("expandRegionEnd", function() {
    it("expands ending region, by 500000", function() {
        expect(mpgSoftware.geneInfo.expandRegionEnd(500000)).toEqual(1000000);
    });
    it("null argument", function() {
        expect(mpgSoftware.geneInfo.expandRegionEnd()).toEqual(0);
    });


});

var  simulatedJsonReturn = {
    BEG: 117962462,
    CHROM: "8",
    END: 118189003,
    EXCHP_T2D_GWS_TOTAL: 3,
    EXCHP_T2D_LWS_TOTAL: 3,
    EXCHP_T2D_NOM_TOTAL: 4,
    EXCHP_T2D_VAR_TOTALS: {
        EU:{COMMON: 3,LOW_FREQUENCY: 0,NS: 81740,RARE: 6,TOTAL: 9}},
    Function_description: "Facilitates the accumulation of zinc from the cytoplasm  to insulin maturation and/or storage processes in insulin-secreting pancreatic beta- cells.",
    GWAS_T2D_GWS_TOTAL: 4,
    GWAS_T2D_LWS_TOTAL: 9,
    GWAS_T2D_NOM_TOTAL: 149,
    GWAS_T2D_VAR_TOTAL: 1144,
    GWS_TRAITS: ["FastGlu","ProIns","T2D"],
    ID: "SLC30A8",
    _13k_T2D_GWS_TOTAL: 0,
    _13k_T2D_LWS_TOTAL: 1,
    _13k_T2D_NOM_TOTAL: 5,
    _13k_T2D_ORIGIN_VAR_TOTALS: {
        'AA':{COMMON: 1,LOW_FREQUENCY: 5,NS: 2025,RARE: 16,SING: 12,TOTAL: 34}}
};

describe("geneFieldOrZero", function() {
    it("geneFieldOrZero accesses ID data", function() {
        expect(mpgSoftware.geneInfo.geneFieldOrZero(simulatedJsonReturn,mpgSoftware.geneInfo.retrieveGeneInfoRec().ID)).toEqual("SLC30A8");
    });
    it("geneFieldOrZero test default value", function() {
        expect(mpgSoftware.geneInfo.geneFieldOrZero(simulatedJsonReturn,mpgSoftware.geneInfo.retrieveGeneInfoRec().SIGMA_T2D_lof_P,47)).toEqual(47);
    });
    it("geneFieldOrZero test tthe nonexistent fields return zero", function() {
        expect(mpgSoftware.geneInfo.geneFieldOrZero(simulatedJsonReturn,mpgSoftware.geneInfo.retrieveGeneInfoRec().SIGMA_T2D_lof_P)).toEqual(0);
    });
});

describe("fillVarianceAndAssociations", function() {
    var phenotype = new UTILS.phenotypeListConstructor(decodeURIComponent("T2D%3Atype+2+diabetes%2CFastGlu%3Afasting+glucose%2CFastIns%3Afasting+insulin%2CProIns%3Afasting+proinsulin%2C2hrGLU_BMIAdj%3Atwo-hour+glucose%2C2hrIns_BMIAdj%3Atwo-hour+insulin%2CHOMAIR%3AHOMA-IR%2CHOMAB%3AHOMA-B%2CHbA1c%3AHbA1c%2CBMI%3ABMI%2CWHR%3Awaist-hip+ratio%2CHeight%3Aheight%2CTC%3Atotal+cholesterol%2CHDL%3AHDL+cholesterol%2CLDL%3ALDL+cholesterol%2CTG%3ATriglycerides%2CCAD%3Acoronary+artery+disease%2CCKD%3Achronic+kidney+disease%2CeGFRcrea%3AeGFR-creat+%28serum+creatinine%29%2CeGFRcys%3AeGFR-cys+%28serum+cystatin+C%29%2CUACR%3Aurinary+albumin-to-creatinine+ratio%2CMA%3Amicroalbuminuria%2CBIP%3Abipolar+disorder%2CSCZ%3Aschizophrenia%2CMDD%3Amajor+depressive+disorder"));
    var anchorDom = document.createElement("div");
    anchorDom.setAttribute('id','gwasTraits');
    it("testing fillVarianceAndAssociations", function() {
        mpgSoftware.geneInfo.fillVarianceAndAssociations(simulatedJsonReturn,true,'show_exchp','show_exseq','show_sigma','rootRegionUrl','rootTraitUrl','rootVariantUrl',phenotype);
        expect(typeof anchorDom !== 'undefined').toBe(true);
    });
});



describe("buildAnchorForVariantSearches", function() {
    it("testing buildAnchorForVariantSearches", function() {
        var returnedAnchor = mpgSoftware.geneInfo.buildAnchorForVariantSearches('displayableContents', 'geneName', 'filter', 'rootVariantUrl');
        expect(returnedAnchor.indexOf('displayableContents')>-1).toBe(true);
        expect(returnedAnchor.indexOf('geneName')>-1).toBe(true);
        expect(returnedAnchor.indexOf('filter')>-1).toBe(true);
        expect(returnedAnchor.indexOf('displayableContents')>-1).toBe(true);
    });
});


describe("fillVariantsAndAssociationLine", function() {
    it("testing fillVariantsAndAssociationLine", function() {
        var anchorDom = document.createElement("div");
        anchorDom.setAttribute('id','variantsAndAssociationsTableBody');
        mpgSoftware.geneInfo.fillVariantsAndAssociationLine(simulatedJsonReturn,
                                                                                 'gwas',
                                                                                 '100',
                                                                                 'chr1:209348715-210349783',
                                                                                 28, 30, 29, 28,
                                                                                 function(){return '<a>'},true,'rootVariantUrl');
        expect(typeof anchorDom !== 'undefined').toBe(true);    });
});
