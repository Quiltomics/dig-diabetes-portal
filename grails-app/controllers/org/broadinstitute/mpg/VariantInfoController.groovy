package org.broadinstitute.mpg

import org.broadinstitute.mpg.diabetes.BurdenService
import org.codehaus.groovy.grails.web.json.JSONObject

/**
 * Controller class to control the /variantInfo section of the T2D site
 */
class VariantInfoController {
    RestServerService   restServerService
    SharedToolsService sharedToolsService
    BurdenService burdenService

    def index() { }

    /***
     *  Launch the page frame that will hold a friendly collection of information about a single variant. The associated Ajax call is  variantAjax
     * @return
     */
    def variantInfo() {
        String variantToStartWith = params.id
        if (variantToStartWith) {
            render(view: 'variantInfo',
                    model: [variantToSearch: variantToStartWith.trim(),
                            show_gwas      : sharedToolsService.getSectionToDisplay(SharedToolsService.TypeOfSection.show_gwas),
                            show_exchp     : sharedToolsService.getSectionToDisplay(SharedToolsService.TypeOfSection.show_exchp),
                            show_exseq     : sharedToolsService.getSectionToDisplay(SharedToolsService.TypeOfSection.show_exseq)])

        }
    }

    /***
     * provide  a nice collection of information about a single variant. This is the Ajax call associated with variantInfo
     * @return
     */
    def variantAjax() {
        String variantToStartWith = params.id
        if (variantToStartWith)      {
            JSONObject jsonObject =  restServerService.retrieveVariantInfoByName (variantToStartWith.trim())
            render(status:200, contentType:"application/json") {
                [variant:jsonObject]
            }

        }
    }

    /**
     * method to service ajax call for the 'What effect on the encoded protein' section/accordion
     *
     * @return
     */
    def proteinEffect (){
        String variantId = params.variantId
        JSONObject jsonObject =  restServerService.gatherProteinEffect ( variantId.trim().toUpperCase())
        render(status:200, contentType:"application/json") {
            [variantInfo:jsonObject]
        }
    }

    /**
     * method to service ajax call for the 'Variant frequency difference for patients with disease' section/accordion
     *
     * @return
     */
    def variantDiseaseRisk (){
        String variantId = params.variantId
        JSONObject jsonObject =  restServerService.combinedVariantDiseaseRisk ( variantId.trim().toUpperCase())
        render(status:200, contentType:"application/json") {
            [variantInfo:jsonObject]
        }
    }

    /**
     * method to service the ajax call for the 'variant association statistics (pvalue/OR)' section/accordion
     *
     * @return
     */
    def variantDescriptiveStatistics (){
        String variantId = params.variantId
        JSONObject jsonObject =  restServerService.combinedVariantAssociationStatistics ( variantId.trim().toUpperCase())
        render(status:200, contentType:"application/json") {
            [variantInfo:jsonObject]
        }
    }

    /**
     * method to service the ajax call for the 'How common is' section/accordion
     *
     * @return
     */
    def howCommonIsVariant(){
        String variantId = params.variantId
        JSONObject jsonObject =  restServerService.howCommonIsVariantAcrossEthnicities ( variantId.trim().toUpperCase())
        render(status:200, contentType:"application/json") {
            [variantInfo:jsonObject]
        }
    }

    /***
     * This call supports the burden test on the variant info page
     * @return
     */
    def burdenTestAjax() {
        // log parameters received
        // Here are some example parameters, as they show up in the params variable
        // params.filterNum=="2" // value=id from burdenTestVariantSelectionOptionsAjax, or 0 if no selection was made (which is a legal choice)
        // params.dataSet=="1" // where 1->13k, 2->26k"
        // params.variantName=="SLC30A8" // string representing gene name
        log.info("got parameters: " + params);

        // cast the parameters
        String variantName = params.variantName;
        String traitFilterOptionId = (params.filterNum ? params.filterNum : "t2d");     // default to t2d if none given

        // TODO - eventually create new bean to hold all the options and have smarts for double checking validity
        JSONObject result = this.burdenService.callBurdenTestForTraitAndDbSnpId(traitFilterOptionId, variantName);

        // send json response back
        render(status: 200, contentType: "application/json") {result}
    }

    /***
     * Get the contents for the filter drop-down box on the burden test section of the gene info page
     * @return
     */
    def burdenTestTraitSelectionOptionsAjax() {
        JSONObject jsonObject = this.burdenService.getBurdenTraitSelectionOptions()

        // log
        log.info("got burden trait options: " + jsonObject);

        // send json response back
        render(status: 200, contentType: "application/json") {jsonObject}
    }

}
