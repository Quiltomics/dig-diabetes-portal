package dport

import grails.transaction.Transactional

@Transactional
class SharedToolsService {

    public String urlEncodedListOfPhenotypes() {
        List<Phenotype> phenotypeList=Phenotype.list()
        StringBuilder sb   = new StringBuilder ("")
        int numberOfPhenotypes  =  phenotypeList.size()
        int iterationCount  = 0
        for (Phenotype phenotype in phenotypeList){
            sb<< (phenotype.databaseKey + ":" + phenotype.name )
            iterationCount++
            if (iterationCount  < numberOfPhenotypes){
                sb<< ","
            }
        }
        return java.net.URLEncoder.encode( sb.toString())
    }



    public String urlEncodedListOfProteinEffect() {
        List<ProteinEffect> proteinEffectList=ProteinEffect.list()
        StringBuilder sb   = new StringBuilder ("")
        int numberOfProteinEffects  =  proteinEffectList.size()
        int iterationCount  = 0
        for (ProteinEffect proteinEffect in proteinEffectList){
            sb<< (proteinEffect.key + ":" + proteinEffect.name )
            iterationCount++
            if (iterationCount  < numberOfProteinEffects){
                sb<< "~"
            }
        }
        return java.net.URLEncoder.encode( sb.toString())
    }

    /***
     * get back a list of filters that we need to pass to the backend. We package them up for a round trip to the client
     * and back via the Ajax call
     *
     * @param listOfAllFilters
     * @return
     */
    public String packageUpFiltersForRoundTrip (List <String> listOfAllFilters)  {

        StringBuilder sb = new  StringBuilder()
        if (listOfAllFilters) {
            for ( int i=0 ; i<listOfAllFilters.size() ; i++ ) {
                sb <<  listOfAllFilters[i]
                if ((i+1)<listOfAllFilters.size()) {
                    sb << ","
                }
            }
        }
        return java.net.URLEncoder.encode(sb.toString())

    }

    /***
     *  we need to  encode the list of parameters so that we can reset them when we reenter  the filter setting form.  It
     *  is certainly true that this is a different form of the same information that is held in BOTH the filter list and the
     *  filterDescription  list.  This one could be passed from a different page, however, so we really want a simple, unambiguous
     *  way to store it and pass it around
     *
     *  Note that these values will be interpreted by the client (browser) and they are guaranteed to have no funny characters.  Therefore
     *  we don't need to URL encode them
     *
     * @param listOfAllEncodedParameters
     * @return
     */
    public String packageUpEncodedParameters (List <String> listOfAllEncodedParameters ) {
        StringBuilder sbEncoded = new  StringBuilder()
        for ( int i=0 ; i<listOfAllEncodedParameters.size() ; i++ ) {
            sbEncoded <<  listOfAllEncodedParameters[i]
            if ((i+1)<listOfAllEncodedParameters.size()) {
                sbEncoded << ","
            }
        }

        return sbEncoded.toString()
    }


}
