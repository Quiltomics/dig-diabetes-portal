package dport.mgr
import dport.SharedToolsService
import dport.people.User
import dport.people.UserRole
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

class UserController {
    SharedToolsService sharedToolsService

    def edit(User userInstance) {

        List<UserRole> userRoleList = UserRole.findAllByUser(userInstance)

        int flag =   sharedToolsService.extractPrivilegeFlags  (userInstance)

        respond userInstance,model:[userPrivs: flag]
    }

    def create = {
        respond new User(params),model:[userPrivs: 1]

    }


    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            int flag =   sharedToolsService.extractPrivilegeFlags  (userInstance)
            respond userInstance.errors, view:'edit',model:[userPrivs: flag]
            return
        }

        userInstance.save flush:true

        int flagsUserWants = sharedToolsService.convertCheckboxesToPrivFlag(params)

        sharedToolsService.storePrivilegesFromFlags ( userInstance, flagsUserWants)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{
                respond userInstance, [status: OK,userPrivs: flagsUserWants] }
        }
    }



    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create',model:[userPrivs: 1]
            return
        }

        userInstance.save flush:true
        int flagsUserWants = sharedToolsService.convertCheckboxesToPrivFlag(params)
        sharedToolsService.storePrivilegesFromFlags ( userInstance, flagsUserWants)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: ['User', userInstance.id])
                redirect userInstance
            }

            '*' {
                respond userInstance, [status: CREATED, privsFlag: flagsUserWants]
            }
        }
    }


    def show(User userInstance) {
        int flag =   sharedToolsService.extractPrivilegeFlags  (userInstance)
        respond userInstance, model:[userPrivs: flag]
    }


    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        sharedToolsService.storePrivilegesFromFlags ( userInstance, 0)

        userInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect controller: "admin", action:"users", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }


    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect controller: "admin", action:"users", method:"GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }



    def index() {

    }



}
