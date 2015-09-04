package dport

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.apache.juli.logging.LogFactory
import temporary.BuildInfo

class HomeController {
    private static final log = LogFactory.getLog(this)
    GrailsApplication grailsApplication
    SharedToolsService sharedToolsService
    def mailService

    /***
     * top-level index routine. This is where we go if somebody types in type2diabetesgenetics.org and nothing else
     */
    def index = {
        if  ((sharedToolsService.getApplicationIsT2dgenes())) {
            render(view:'portalHome', model: [ticker:"${sharedToolsService.getWarningText()}",
                                              show_gwas:sharedToolsService.getSectionToDisplay (SharedToolsService.TypeOfSection.show_gwas),
                                              show_exchp:sharedToolsService.getSectionToDisplay (SharedToolsService.TypeOfSection.show_exchp),
                                              show_exseq:sharedToolsService.getSectionToDisplay (SharedToolsService.TypeOfSection.show_exseq)])
        }  else if (sharedToolsService.getApplicationIsBeacon()) {
            redirect(controller:'beacon', action:'beaconDisplay')
        } else {
            log.error ">>>>> Critical internal error!  The application was set to something other than T2dgenes, Sigma, or Beacon.  No home page possible.  <<<<<"
        }

    }

    /***
     * This is our standard home page. We get directed here from a few places in the portal
     */
    def portalHome = {
        render(controller: 'home', view: 'portalHome', model: [ticker:"${sharedToolsService.getWarningText()}",
                                                               show_gwas:sharedToolsService.getSectionToDisplay (SharedToolsService.TypeOfSection.show_gwas),
                                                               show_exchp:sharedToolsService.getSectionToDisplay (SharedToolsService.TypeOfSection.show_exchp),
                                                               show_exseq:sharedToolsService.getSectionToDisplay (SharedToolsService.TypeOfSection.show_exseq)])
    }

    /***
     * The very first time you use the portal you have to sign something.  This should happen to everyone EXCEPT those
     * with built-in login accounts (i.e. system users) who will never see this message.
     */
    def signAContract = {
        render(controller: 'home', view: 'signAContract')
    }

    /***
     * prep to show a video. Get here from the tutorial link
     */
    def introVideoHolder = {
        render(controller: 'home', view: 'introVideoHolder')
    }

    /***
     * I think we still support the Beacon application.  Someone should really split this out into its own app.
     */
    def beaconHome = {
        render(view: 'beaconDisplay')
    }

    /***
     * If something has gone on the browser, then the browser calls this action in order to make sure
     * that the failure gets around.  Unfortunately these are not necessarily real errors -- if for example
     * you are waiting for an Ajax response and you get impatient and leave the page then you're going to
     * generate this error response.  I don't know a good way to differentiate between real and non-real errors
     * on the browser yet.
     */
    def errorReporter = {
        String errorText = params['errorText']
        log.error "*** Received error from client reporter. text=${errorText}"
        if ((errorText !=  null ) &&
            (errorText != "null")) {  // There is no point in sending a completely empty message.
                                      // Note that the 'null' message will go into the logs, so it isn't
                                      // completely lost, however, even if it doesn't fill up my email box
            mailService.sendMail {
                from "t2dPortal@gmail.com"
                to "${grailsApplication.config.site.operator}"
                subject "Error report"
                body "${errorText}"
            }
        }
        render(status: 200)
    }

}
