package dport

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(VariantController)
class VariantControllerUnitSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }


    void "test index"() {
        when:
        controller.index()

        then:
        response.status == 200

    }

}
