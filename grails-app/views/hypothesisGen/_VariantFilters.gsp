<div class="row">
    <div class="col-sm-11">
        <div class="dbtBoundingBox">

            <div class="row">
                    <div class="col-sm-12">
                        <div class="subsectionHolder">
                        <div class="row">
                           <div class="col-sm-3"></div>
                           <div class="col-sm-6"><strong><g:message code='hypothesisGen.variantFilters.specify_variant'/></strong></div>
                           <div class="col-sm-3"></div>
                        </div>
                        <div class="row dbtBoundingBoxSubrow">
                            <ul class="list-group">
                                <li class="list-group-item">
                                    <g:form action="variantUpload">
                                    <div class="row">
                                        <div class="col-sm-5"> <g:message code='hypothesisGen.variantFilters.variant_upload.by_type'/></div>
                                        <div class="col-sm-5">
                                            <g:textField name="explicitVariants" size="45" placeholder="each variant in quotes, separated by commas"/>
                                            </div>
                                        <div class="col-sm-2"><input type="submit"   class="btn btn-default btn-sm" /></div>
                                    </div>
                                   </g:form>
                                </li>
                                <li class="list-group-item">
                                    <g:uploadForm action="variantFileUpload">
                                        <div class="row">
                                            <div class="col-sm-5"> <g:message code='hypothesisGen.variantFilters.variant_upload.by_file'/></div>
                                            <div class="col-sm-5"><input type="file"  class="btn btn-default btn-sm" name="myVariantFile"  size="45" /></div>
                                            <div class="col-sm-2"><input type="submit"   class="btn btn-default btn-sm" /></div>
                                        </div>
                                    </g:uploadForm>
                                </li>
                            </ul>
                        </div>

                        </div>
                    </div>
            </div>


        </div>
    </div>
    <div class="col-sm-1"></div>
</div>
