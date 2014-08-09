package dport

class HtmlTagLib {
    static defaultEncodeAs = [taglib: 'html']

    def renderHtml = {attrs ->

        def filePath = attrs.file

        if (!filePath) {
            throwTagError("'file' attribute must be provided")
        }
        IOUtils.copy((String)request.servletContext.getResourceAsStream(filePath), out);
    }


    def renderGeneSummary = {attrs ->

        String geneName = attrs.geneFile

        if (!geneName) {
            throwTagError("'file' attribute must be provided")
        }

        String fileName =  "/WEB-INF/resources/geneSummaries/${geneName}.html"

        String fileDesignationOnDisk =  grailsApplication.mainContext.getResource(fileName).file.toString()


        if (!fileDesignationOnDisk) {
            throwTagError("could not find ${fileName} on disk")
        }
        File file = new File(fileDesignationOnDisk)
        String fileContents = ""

        file.eachLine {
            fileContents += it
        }
        //  StringWriter writer = new java.io.StringWriter();
        // def f=request.servletContext.getResourceAsStream(fileDesignationOnDisk);
        //IOUtils.copy((java.io.InputStream)request.servletContext.getResourceAsStream(fileDesignationOnDisk), writer);
        out << fileContents
    }
}





