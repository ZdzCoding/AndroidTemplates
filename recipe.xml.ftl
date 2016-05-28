<?xml version="1.0"?>
<recipe>

	<instantiate from="src/app_package/CustomAdapter.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/adapter/${itemClass}Adapter.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/adapter/${itemClass}Adapter.java" />

    <instantiate from="src/app_package/Fragment.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/fragment/${itemClass}Fragment.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/fragment/${itemClass}Fragment.java" />

    <instantiate from="src/app_package/BasePresenter.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/presenter/${itemClass}Presenter.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/presenter/${itemClass}Presenter.java" />

    <instantiate from="src/app_package/BaseContract.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/presenter/${itemClass}Contract.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/presenter/${itemClass}Contract.java" />

    <instantiate from="src/app_package/BaseInteractor.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/interactor/${itemClass}InteractorImpl.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/interactor/${itemClass}Interactor.java" />

    <instantiate from="src/app_package/BaseModel.java.ftl"
                       to="${escapeXmlAttribute(srcOut)}/model/${itemClass}.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/model/${itemClass}.java" />

    <instantiate from="res/layout/item_simple.xml.ftl"
              to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

	<instantiate from="res/layout/fragment_simple.xml.ftl"
              to="${escapeXmlAttribute(resOut)}/layout/${fragment_layoutName}.xml" />
</recipe>
