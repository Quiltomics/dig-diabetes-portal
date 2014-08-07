package dport

import org.codehaus.groovy.grails.web.json.JSONObject

class TraitController {
    RestServerService restServerService

    def index() {}
    def traitSearch() {
        String phenotypeKey=params.trait
        String requestedSignificance=params.significance
        render (view: 'phenotype',
                model:[show_gwas:1,
                       show_exchp: 1,
                       show_exseq: 1,
                       show_sigma: 0,
                       phenotypeKey:phenotypeKey,
                       requestedSignificance:requestedSignificance] )

    }
     def phenotypeAjax() {
            String significance = params["significance"]
            String phenotypicTrait  = params["trait"]
            BigDecimal significanceValue
            try {
                significanceValue = new BigDecimal(significance)
            } catch (NumberFormatException nfe)  {
                println "User supplied a nonnumeric significance value = '${significance}'"
                // TODO: error condition.  Go with GWAS significance
                significantValue = 0.00000005
            }
            JSONObject jsonObject = restServerService.searchTraitByName(phenotypicTrait,significanceValue)
            render(status:200, contentType:"application/json") {
                [variant:jsonObject['variants']]
            }

    }

}
