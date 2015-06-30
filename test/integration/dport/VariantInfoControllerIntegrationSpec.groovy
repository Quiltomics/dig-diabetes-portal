/**
 * Created by ben on 8/16/2014.
 */
package dport

import grails.converters.JSON
import grails.test.spock.IntegrationSpec

/**
 *
 */
class VariantInfoControllerIntegrationSpec extends IntegrationSpec {

    VariantInfoController controller


    def setup() {
        controller = new  VariantInfoController()
    }

    def cleanup() {
    }




    void "test the variantInfo page"() {
        when:
        controller.params.id='rs853787'
        controller.variantInfo()

        then: 'verify that we get valid responses back'
        assert controller.response.status==200

    }


}

