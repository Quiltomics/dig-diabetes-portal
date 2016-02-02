package org.broadinstitute.mpg

import org.apache.commons.lang.StringEscapeUtils;

class HtmlTagLib {
//    static defaultEncodeAs = [taglib: 'html']

//    def renderHtml = {attrs ->
//
//        def filePath = attrs.file
//
//        if (!filePath) {
//            throwTagError("'file' attribute must be provided")
//        }
//        IOUtils.copy((String)request.servletContext.getResourceAsStream(filePath), out);
//    }


    def renderGeneSummary = { attrs ->

        String geneName = attrs.geneFile
        String locale = attrs.locale

        if (!geneName) {
            return;  // better to fail silently
            //throwTagError("'file' attribute must be provided")
        }

        String fileName = "/WEB-INF/resources/geneSummaries/${geneName}.html" // default value
        if (locale) {
            if (locale.startsWith("en")) {
                fileName = "/WEB-INF/resources/geneSummaries/${geneName}.html"
            } else if (locale.startsWith("es")) {
                fileName = "/WEB-INF/resources/geneSummaries/spanish/${geneName}.html"
            }
        }

        String fileDesignationOnDisk = grailsApplication.mainContext.getResource(fileName).file.toString()


        if (!fileDesignationOnDisk) {
            throwTagError("could not find ${fileName} on disk")
        }
        File file = new File(fileDesignationOnDisk)
        String fileContents = ""

        file.eachLine {
            String rawCharacters = it
            fileContents += StringEscapeUtils.escapeJavaScript(rawCharacters)
        }
        out << fileContents
    }
}





