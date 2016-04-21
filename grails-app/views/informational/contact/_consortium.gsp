


        <g:if test="${!g.portalTypeString()?.equals('stroke')}">
            <h2><g:message code="contact.consortium_leader"/></h2>
        </g:if>

        <g:if test="${g.portalTypeString()?.equals('stroke')}">
            <h3><g:message code="informational.shared.cohort.stroke"/></h3>
            <a href="mailto://woodl@ucmail.uc.edu">Dan Woo</a> | <g:message code="informational.shared.institution.univ_cincinnati"/> <br/>
            <a href="mailto://sdebette@bu.edu">Stephanie Debette</a> | <g:message code="informational.shared.institution.bordeaux_university"/> <br/>
        </g:if>
        <g:else>
            <h3><g:message code="informational.shared.cohort.t2dgenes"/></h3>
            <a href="mailto://altshuler@molbio.mgh.harvard.edu">David Altshuler</a> | <g:message code="informational.shared.institution.broad_institute"/> <br/>
            <a href="mailto://JCFLOREZ@mgh.harvard.edu">Jose Florez</a> | <g:message code="informational.shared.institution.broad_institute"/> <br/>
            <a href="mailto://boehnke@umich.edu">Michael Boehnke</a> | <g:message code="informational.shared.institution.umich"/> <br/>
            <a href="mailto://mark.mccarthy@drl.ox.ac.uk">Mark McCarthy</a> | <g:message code="informational.shared.institution.oxford"/> <br/>
            <a href="mailto://craig.l.hanis@uth.tmc.edu">Craig Hanis</a> | <g:message code="informational.shared.institution.UTHSC"/> <br/>
            <a href="mailto://ravid@txbiomedgenetics.org">Ravi Duggirala</a> | <g:message code="informational.shared.institution.TBRI"/> <br/>

            <h3><g:message code="informational.shared.cohort.GoT2D"/></h3>
            <a href="mailto://altshuler@molbio.mgh.harvard.edu">David Altshuler</a> | <g:message code="informational.shared.institution.broad_institute"/> <br/>
            <a href="mailto://JCFLOREZ@mgh.harvard.edu">Jose Florez</a> | <g:message code="informational.shared.institution.broad_institute"/> <br/>
            <a href="mailto://boehnke@umich.edu">Michael Boehnke</a> | <g:message code="informational.shared.institution.umich"/> <br/>
            <a href="mailto://mark.mccarthy@drl.ox.ac.uk">Mark McCarthy</a> | <g:message code="informational.shared.institution.oxford"/> <br/>
            <a href="mailto://leif.groop@med.lu.se">Leif Groop</a> | <g:message code="informational.shared.institution.lund"/> <br/>
            <a href="mailto://Meitinger@helmholtz-muenchen.de">Thomas Meitinger</a> | <g:message code="informational.shared.institution.IHG"/> <br/>
        </g:else>


