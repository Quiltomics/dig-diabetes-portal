package dport

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(TraitController)
class TraitControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test empty constructor"() {
        when:
        Phenotype phenotype = new Phenotype()

        then:
        assertNotNull(phenotype)
        assertNotNull(gene.name1)

    }


    void "test something"() {
    }
}
