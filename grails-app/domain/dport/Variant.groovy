package dport

class Variant {

        String dbSnpId = ''
        String varId = ''
        String chromosome = ''
        Long position = 0l

        static constraints = {
            varId blank: false
            dbSnpId blank: true
            chromosome blank: false
            position position: true
        }


        static Variant retrieveVariant(String variantName) {
            Variant variant = null
            if (variantName) {
                String uppercaseVariantName =  variantName.toUpperCase()
                variant = Variant.findByVarId(uppercaseVariantName)
                if (variant ==  null ) {
                    variant = Variant.findByVarId(uppercaseVariantName)
                }
            }
            return variant
        }


        static void refresh(String varId, String dbSnpId,String chromosome, Long position) {
            Variant variant = retrieveVariant(varId)
            if ((variant?.varId != varId) &&
                    (variant?.chromosome != chromosome) &&
                    (variant?.position != position)) {
                if (variant != null) {
                    variant.delete(flush: true)
                }
                new Variant(dbSnpId: dbSnpId,
                        varId: varId,
                        chromosome: chromosome,
                        position: position).save()
            }
        }


        static void deleteVariantsForChromosome(String chromosome) {
            List<Variant> variantList = Variant.findAllByChromosome(chromosome)
            for (Variant variant in variantList) {
                variant.delete(flush: true)
            }
        }


    }
