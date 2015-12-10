package org.broadinstitute.mpg.diabetes.metadata.result;

import org.broadinstitute.mpg.diabetes.knowledgebase.result.PropertyValue;
import org.broadinstitute.mpg.diabetes.knowledgebase.result.Variant;
import org.broadinstitute.mpg.diabetes.util.PortalException;
import org.codehaus.groovy.grails.web.json.JSONArray;
import org.codehaus.groovy.grails.web.json.JSONObject;

import java.util.List;

/**
 * Created by mduby on 12/8/15.
 */
public class KnowledgeBaseFlatSearchTranslator implements KnowledgeBaseResultTranslator {
    // constants
    private final String KEY_ANALYSIS               = "analysis";
    private final String KEY_ID                     = "id";
    private final String KEY_POSITION               = "position";
    private final String KEY_CHROMOSOME             = "chr";
    private final String KEY_REF_ALLELE_FREQ        = "refAlleleFreq";
    private final String KEY_REF_ALLELE             = "refAllele";
    private final String KEY_SCORE_TEST_STAT        = "scoreTestStat";
    private final String KEY_P_VALUE                = "pvalue";


    // instance variables
    private String defaultDataSetKey = null;
    private String defaultPhenotypeKey = null;
    private String defaultPropertyKey = null;

    /**
     * default constructor that sets the 3 values needed to search for the property to plot
     *
     * @param dataSetKey
     * @param phenotypeKey
     * @param propertyKey
     */
    public KnowledgeBaseFlatSearchTranslator(String dataSetKey, String phenotypeKey, String propertyKey) {
        this.defaultDataSetKey = dataSetKey;
        this.defaultPhenotypeKey = phenotypeKey;
        this.defaultPropertyKey = propertyKey;
    }

    /**
     * translate a list of vartiants into a flat json result
     *
     * @param resultList
     * @return
     * @throws PortalException
     */
    public JSONObject translate(List<Variant> resultList) throws PortalException {
        // local variables
        JSONObject rootObject = new JSONObject();
        PropertyValue tempPropertyValue;

        // variables to store properties
        Integer position;
        String varId;
        String chromosome;
        String referenceAllele;
        Double pValue;

        // make sure translator properly initialized
        if (this.defaultDataSetKey == null) {
            throw new PortalException("Missing initializing data set key for the flat result translator");

        } else if (this.defaultPhenotypeKey == null) {
            throw new PortalException("Missing initializing phenotype key for the flat result translator");

        } else if (this.defaultPropertyKey == null) {
            throw new PortalException("Missing initializing property key for the flat result translator");
        }

        // brute force build one json array for each attribute
        JSONArray analysisArray = new JSONArray();
        rootObject.put(KEY_ANALYSIS, analysisArray);

        JSONArray idArray = new JSONArray();
        rootObject.put(KEY_ID, idArray);

        JSONArray chromosomeArray = new JSONArray();
        rootObject.put(KEY_CHROMOSOME, chromosomeArray);

        JSONArray positionArray = new JSONArray();
        rootObject.put(KEY_POSITION, positionArray);

        JSONArray refAlleleFrequencyArray = new JSONArray();
        rootObject.put(KEY_REF_ALLELE_FREQ, refAlleleFrequencyArray);

        JSONArray refAlleleArray = new JSONArray();
        rootObject.put(KEY_REF_ALLELE, refAlleleArray);

        JSONArray pValueArray = new JSONArray();
        rootObject.put(KEY_P_VALUE, pValueArray);

        JSONArray scoreTestStatArray = new JSONArray();
        rootObject.put(KEY_SCORE_TEST_STAT, scoreTestStatArray);

        // loop through the variants and populate the json arrays
        for (int i = 0; i < resultList.size(); i++) {
            // reinitialize variables
            position = null;
            varId = null;
            chromosome = null;
            referenceAllele = null;
            pValue = null;

            // get the variant
            Variant variant = resultList.get(i);

            // add in the var id
            tempPropertyValue = variant.getPropertyValueFromCollection("VAR_ID", null, null);
            if (tempPropertyValue.getValue() != null) {
                varId = tempPropertyValue.getValue();
            }

            // add in the position
            tempPropertyValue = variant.getPropertyValueFromCollection("POS", null, null);
            if ((tempPropertyValue != null) && (tempPropertyValue.getValue() != null)) {
                try {
                        position = Integer.parseInt(tempPropertyValue.getValue());
                } catch (NumberFormatException exception) {
                    // do nothing; value will be null
                }
            }

            // add in the ref allele
            tempPropertyValue = variant.getPropertyValueFromCollection("Reference_Allele", null, null);
            if (tempPropertyValue.getValue() != null) {
                referenceAllele = tempPropertyValue.getValue();
            }

            // add in the chromosome
            tempPropertyValue = variant.getPropertyValueFromCollection("CHROM", null, null);
            if (tempPropertyValue.getValue() != null) {
                chromosome = tempPropertyValue.getValue();
            }

            // add in the pValue
            tempPropertyValue = variant.getPropertyValueFromCollection(this.defaultPropertyKey, this.defaultDataSetKey, this.defaultPhenotypeKey);
            if ((tempPropertyValue != null) && (tempPropertyValue.getValue() != null)) {
                try {
                    pValue = Double.valueOf(tempPropertyValue.getValue());
                } catch (NumberFormatException exception) {
                    // do nothing; value will be null
                }
            }

            // if al values there and no issues, then add to arrays (want to make sure to keep arrays synched)
            // add in the ref allele frequency
            refAlleleFrequencyArray.put(null);
            analysisArray.put(3);
            positionArray.put(position);
            pValueArray.put(pValue);
            chromosomeArray.put(chromosome);
            idArray.put(varId);
            scoreTestStatArray.put(null);
            refAlleleArray.put(referenceAllele);
        }

        // return
        return rootObject;
    }
}
