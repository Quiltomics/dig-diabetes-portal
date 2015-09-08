package org.broadinstitute.mpg.diabetes.metadata.query;

import junit.framework.TestCase;
import org.broadinstitute.mpg.diabetes.metadata.Property;
import org.broadinstitute.mpg.diabetes.metadata.parser.JsonParser;
import org.broadinstitute.mpg.diabetes.util.PortalConstants;
import org.broadinstitute.mpg.diabetes.util.PortalException;
import org.junit.Before;
import org.junit.Test;

import java.io.InputStream;
import java.util.List;
import java.util.Scanner;

/**
 * Created by mduby on 9/7/15.
 */
public class JsNamingQueryTranslatorTest extends TestCase {
    // local variables
    JsonParser jsonParser;
    JsNamingQueryTranslator jsNamingQueryTranslator;

    @Before
    public void setUp() throws Exception {
        // set the json builder
        this.jsonParser = JsonParser.getService();
        InputStream inputStream = getClass().getResourceAsStream("../parser/metadata.json");
        String jsonString = new Scanner(inputStream).useDelimiter("\\A").next();
        this.jsonParser.setJsonString(jsonString);

        // set up the translator
        this.jsNamingQueryTranslator = new JsNamingQueryTranslator();
    }

    @Test
    public void testChromosomeFilter() {
        // local variables
        String inputString = "8=7";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get(PortalConstants.PROPERTY_KEY_COMMON_GENE);

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("7", queryFilter.getValue());
    }

    @Test
    public void testStartPositionFilter() {
        // local variables
        String inputString = "9=4747";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get(PortalConstants.PROPERTY_KEY_COMMON_POSITION);

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_MORE_THAN_EQUALS, queryFilter.getOperator());
        assertEquals(property, queryFilter.getProperty());
        assertEquals("4747", queryFilter.getValue());
    }

    @Test
    public void testEndPositionFilter() {
        // local variables
        String inputString = "10=4848";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get(PortalConstants.PROPERTY_KEY_COMMON_POSITION);

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_LESS_THAN_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("4848", queryFilter.getValue());
    }

    @Test
    public void testGenericPropertyEqualsFilter() {
        // local variables
        String inputString = "17=BIP[GWAS_PGC_mdv2]P_VALUE|1";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get("metadata_root_GWAS_PGC_mdv2_PGCBIPP_VALUE");

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("1", queryFilter.getValue());
    }

    @Test
    public void testGenericPropertyMoreThanFilter() {
        // local variables
        String inputString = "17=BIP[GWAS_PGC_mdv2]P_VALUE>1";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get("metadata_root_GWAS_PGC_mdv2_PGCBIPP_VALUE");

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_MORE_THAN_NOT_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("1", queryFilter.getValue());
    }

    @Test
    public void testGenericPropertyLessThanFilter() {
        // local variables
        String inputString = "17=BIP[GWAS_PGC_mdv2]P_VALUE<1";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get("metadata_root_GWAS_PGC_mdv2_PGCBIPP_VALUE");

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_LESS_THAN_NOT_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("1", queryFilter.getValue());
    }

    @Test
    public void testMostDelScoreEqualsFilter() {
        // local variables
        String inputString = "11=MOST_DEL_SCORE|1";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get("metadata_rootMOST_DEL_SCORE");

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("1", queryFilter.getValue());
    }

    @Test
    public void testPolyphenEqualsFilter() {
        // local variables
        String inputString = "11=PolyPhen_PRED|1";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get("metadata_rootPolyPhen_PRED");

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("1", queryFilter.getValue());
    }

    @Test
    public void testSiftPredictorEqualsFilter() {
        // local variables
        String inputString = "11=SIFT_PRED|1";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get("metadata_rootSIFT_PRED");

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("1", queryFilter.getValue());
    }

    @Test
    public void testCondelPredictorEqualsFilter() {
        // local variables
        String inputString = "11=Condel_PRED|1";
        QueryFilter queryFilter = null;
        Property property = null;

        try {
            // get the comparing property
            property = (Property)this.jsonParser.getMapOfAllDataSetNodes().get("metadata_rootCondel_PRED");

            // get the filter
            queryFilter = this.jsNamingQueryTranslator.convertJsNamingQuery(inputString);

        } catch (PortalException exception) {
            fail("got filter creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilter);
        assertNotNull(queryFilter.getOperator());
        assertNotNull(queryFilter.getValue());
        assertNotNull(queryFilter.getProperty());
        assertEquals(PortalConstants.OPERATOR_EQUALS, queryFilter.getOperator());
        assertEquals(property.getId(), queryFilter.getProperty().getId());
        assertEquals("1", queryFilter.getValue());
    }

    @Test
    public void testGetMultipleQueryFilters() {
        // local variables
        String inputString = "17=T2D[ExSeq_17k_mdv2]P_FIRTH_FE_IV<.1^17=T2D[ExSeq_17k_mdv2]MAF<.5^8=8^9=117862462^10=118289003^11=MOST_DEL_SCORE|1^11=Condel_PRED|1^";
        List<QueryFilter> queryFilterList = null;
        Property property = null;

        try {
            // get the filter
            queryFilterList = this.jsNamingQueryTranslator.getQueryFilters(inputString);

        } catch (PortalException exception) {
            fail("got filter list creation exception: " + exception.getMessage());
        }

        // test
        assertNotNull(queryFilterList);
        assertEquals(7, queryFilterList.size());
    }
}
