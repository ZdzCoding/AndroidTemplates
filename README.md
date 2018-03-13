# AndroidTemplates 使用

转载请注明出处：http://blog.csdn.net/zhaodai11?viewmode=contents

上篇文章介绍的方法只能创建类模板，不能创建xml文件等资源文件以及配置文件等，这篇文章来介绍创建可以一次创建多个文件多种类型文件的方法。

我们在使用AndroidStudio创建Activity的时候一般java文件，xml文件，以及在androidmanifest.xml配置文件中配置已经完成。

上篇文章讲到AndroidStudio的文件模板放在安装目录下/plugins/Android/lib/templates 文件夹下面。
![安装目录](http://img.blog.csdn.net/20160528155518855)
可以看到里面那些正是AndroidStudio默认提供的Activity类型（我截图里面多了几个，是我自己测试写的）。

下面我们分析最简单的一个模板EmptyActivity,EmptyActivity文件夹下面包括：
![模板文件夹内容](http://img.blog.csdn.net/20160528160039565)

Android Studio 使用的是freeMaker模板引擎，所以文件夹下面的文件后缀名都是.ftl。

 - globals.xml.ftl      全局变量文件  存放的是一些全局变量
 - recipe.xml.ftl       配置要引用的模板路径以及生成文件的路径
 - template.xml    模板的配置信息,以及要输入的参数.定义了模板的流程框架 基本结构
 - template_blank_activity.png  显示的缩略图（只是展示用）
 -  SimpleActivity.java.ftl   Activity模板文件
 
 globals.xml.ftl   定义了一些全局变量 以及将 common_globals.xml.ftl 文件中的全局变量引入
```
<?xml version="1.0"?>
<globals>
    <global id="hasNoActionBar" type="boolean" value="false" />
    <global id="parentActivityClass" value="" />
    <global id="simpleLayoutName" value="${layoutName}" />
    <global id="excludeMenu" type="boolean" value="true" />
    <global id="generateActivityTitle" type="boolean" value="false" />
    <#include "../common/common_globals.xml.ftl" />
</globals>

```
common_globals.xml.ftl

```
<globals>
    <#assign theme=getApplicationTheme()!{ "name": "AppTheme", "isAppCompat": true }>
    <#assign themeName=theme.name!'AppTheme'>
    <#assign themeNameNoActionBar=theme.nameNoActionBar!'AppTheme.NoActionBar'>
    <#assign appCompat=theme.isAppCompat!false>
    <#assign appCompatActivity=appCompat && (buildApi gte 22)>

    <global id="themeName" type="string" value="${themeName}" />
    <global id="implicitParentTheme" type="boolean" value="${(themeNameNoActionBar?starts_with(themeName+'.'))?string}" />
    <global id="themeNameNoActionBar" type="string" value="${themeNameNoActionBar}" />
    <global id="themeExistsNoActionBar" type="boolean" value="${(theme.existsNoActionBar!false)?string}" />
    <global id="themeNameAppBarOverlay" type="string" value="${theme.nameAppBarOverlay!'AppTheme.AppBarOverlay'}" />
    <global id="themeExistsAppBarOverlay" type="boolean" value="${(theme.existsAppBarOverlay!false)?string}" />
    <global id="themeNamePopupOverlay" type="string" value="${theme.namePopupOverlay!'AppTheme.PopupOverlay'}" />
    <global id="themeExistsPopupOverlay" type="boolean" value="${(theme.existsPopupOverlay!false)?string}" />

    <global id="appCompat" type="boolean" value="${((isNewProject!false) || (theme.isAppCompat!false))?string}" />
    <global id="appCompatActivity" type="boolean" value="${appCompatActivity?string}" />
    <global id="hasAppBar" type="boolean" value="${appCompatActivity?string}" />
    <global id="hasNoActionBar" type="boolean" value="${appCompatActivity?string}" />
    <global id="manifestOut" value="${manifestDir}" />
    <global id="buildVersion" value="${buildApi}" />

<#if !appCompat>
    <global id="superClass" type="string" value="Activity"/>
    <global id="superClassFqcn" type="string" value="android.app.Activity"/>
    <global id="Support" value="" />
    <global id="actionBarClassFqcn" type = "string" value="android.app.ActionBar" />
<#elseif appCompatActivity>
    <global id="superClass" type="string" value="AppCompatActivity"/>
    <global id="superClassFqcn" type="string" value="android.support.v7.app.AppCompatActivity"/>
    <global id="Support" value="Support" />
    <global id="actionBarClassFqcn" type = "string" value="android.support.v7.app.ActionBar" />
<#else>
    <global id="superClass" type="string" value="ActionBarActivity"/>
    <global id="superClassFqcn" type="string" value="android.support.v7.app.ActionBarActivity"/>
    <global id="Support" value="Support" />
    <global id="actionBarClassFqcn" type = "string" value="android.support.v7.app.ActionBar" />
</#if>

    <global id="srcOut" value="${srcDir}/${slashedPackageName(packageName)}" />
    <global id="resOut" value="${resDir}" />
    <global id="menuName" value="${classToResource(activityClass!'')}" />
    <global id="simpleName" value="${activityToLayout(activityClass!'')}" />
    <global id="relativePackage" value="<#if relativePackage?has_content>${relativePackage}<#else>${packageName}</#if>" />
</globals>
```

recipe.xml.ftl  、recipe_manifest.xml.ftl、recipe_simple.xml.ftl

```
<?xml version="1.0"?>
<recipe>
    <#include "../common/recipe_manifest.xml.ftl" />

<#if generateLayout>
    <#include "../common/recipe_simple.xml.ftl" />
    <open file="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
</#if>

    <instantiate from="root/src/app_package/SimpleActivity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />

    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
</recipe>


//recipe_manifest.xml.ftl
<recipe folder="root://activities/common">

    <merge from="root/AndroidManifest.xml.ftl"             to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml" />
    
    <merge from="root/res/values/manifest_strings.xml.ftl"
             to="${escapeXmlAttribute(resOut)}/values/strings.xml" />

</recipe>

//recipe_simple.xml.ftl
<recipe folder="root://activities/common">

<#if appCompat && !(hasDependency('com.android.support:appcompat-v7'))>
    <dependency mavenUrl="com.android.support:appcompat-v7:${buildApi}.+"/>
</#if>

    <instantiate from="root/res/layout/simple.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${simpleLayoutName}.xml" />

<#if (isNewProject!false) && !(excludeMenu!false)>
    <#include "recipe_simple_menu.xml.ftl" />
</#if>

    <#include "recipe_simple_dimens.xml" />
</recipe>


```
这里<#if >是freeMaker的if判断标签，对freeMaker我也不太熟悉，大家感兴趣可以去看一下freeMaker语法。

```
<instantiate from="root/src/app_package/SimpleActivity.java.ftl"           to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
```
这句是根据root/src/app_package/SimpleActivity.java.ftlSimpleActivity.java.ftl模板文件生成escapeXmlAttribute(srcOut)目录下对应${activityClass}.java文件，escapeXmlAttribute(srcOut)这个是指你选择的目录即你点击右键时的目录。

```
 <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
</recipe>
```
同样这句的作用是生成后打开这个文件。

```
<merge from="root/AndroidManifest.xml.ftl"             to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml" />
```
merge标签代表是将AndroidManifest.xml.ftl模板文件中的内容添加到AndroidManifest.xml文件中，并不是覆盖。


template.xml 

```
<?xml version="1.0"?>
<template
    format="5"
    revision="5"
    name="Empty Activity"  在向导界面中显示的模板名称
    minApi="7"
    minBuildApi="14"
    description="Creates a new empty activity"> 界面中显示描述 

    <category value="Activity" />   模板所属类型  这个可以自定义 
    <formfactor value="Mobile" />

    <parameter
        id="activityClass"  唯一标示，可以用${activityClass}获取value 
        name="Activity Name" 界面输入框前的提示文字 
        type="string" 类型 界面显示为输入框
        constraints="class|unique|nonempty" 约束 class必须是类名 unique唯一 nonempty不能为空  
        suggest="${layoutToActivity(layoutName)}" 建议的名称 默认生成的名称和布局文件名称关联  不太确定 汗
        default="MainActivity" 默认值
        help="The name of the activity class to create" /> 界面提示文字 

    <parameter
        id="generateLayout"
        name="Generate Layout File"
        type="boolean" 界面显示为勾选框  type="enum" 在界面中为下拉选择框
        default="true"
        help="If true, a layout file will be generated" />

    <parameter
        id="layoutName"
        name="Layout Name"
        type="string"
        constraints="layout|unique|nonempty"
        suggest="${activityToLayout(activityClass)}"
        default="activity_main"
        visibility="generateLayout"
        help="The name of the layout to create for the activity" />

    <parameter
        id="isLauncher"
        name="Launcher Activity"
        type="boolean"
        default="false"
        help="If true, this activity will have a CATEGORY_LAUNCHER intent filter, making it visible in the launcher" />
    
    <parameter
        id="packageName"
        name="Package name"
        type="string"
        constraints="package"
        default="com.mycompany.myapp" />

	缩略图
    <!-- 128x128 thumbnails relative to template.xml -->
    <thumbs>
        <!-- default thumbnail is required -->
        <thumb>template_blank_activity.png</thumb>
    </thumbs>

	引入全局配置文件
    <globals file="globals.xml.ftl" />

	根据模板生成对应的文件
    <execute file="recipe.xml.ftl" />

</template>
```
下面配一张图
![这里写图片描述](http://img.blog.csdn.net/20160528191039664)
 SimpleActivity.java.ftl     Activity模板文件
```
package ${packageName};  

import ${superClassFqcn};
import android.os.Bundle;

public class ${activityClass} extends ${superClass} {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
<#if generateLayout>
        setContentView(R.layout.${layoutName});
</#if>
    }
}

```
`${activityClass} ${superClass}`  其他文件中对变量的引用，都是前面定义的一些参数，一般主要出自两个地方，一个是globals.xml  全局变量文件，第二个是template.xml 界面中定义变量。
这种根据模板生成更类似于一种文件拷贝，不会检查语法。

上面是理论基础。下面我们来实战一下,顺便解决一下上篇文章的问题如何生成多个文件，以及不同类型的文件。

**实战须知：**
**建议大家在修改之前，现将整个文件夹备份一下，免得改乱了。文件夹也不大。**

- globals.xml      全局变量文件  存放的是一些全局变量
 - recipe.xml       配置要引用的模板路径以及生成文件的路径
 - template.xml    模板的配置信息,以及要输入的参数.定义了模板的流程框架 基本结构
 - template_blank_activity.png  显示的缩略图（只是展示用）
 -  SimpleActivity.java.ftl   Activity模板文件
 - ***.**.ftl  对应类型的模板文件

**globals.xml.ftl  全局变量文件  存放的是一些全局变量**

```
<?xml version="1.0"?>
<globals>
    <global id="resOut" value="${resDir}" />
    <global id="srcOut" value="${srcDir}/${slashedPackageName(packageName)}" />
    <global id="collection_name" value="${extractLetters(itemClass?lower_case)}" />   
</globals>
```

**recipe.xml.ftl 配置要引用的模板路径以及生成文件的路径。
一次性生成多个文件，在于使用`<instantiate>`标签，只要写好引用模板文件和输出文件路径和文件名。**

```
<?xml version="1.0"?>
<recipe>
	<!-- 生成Adapter 文件-->
	<instantiate from="src/app_package/CustomAdapter.java.ftl"                       to="${escapeXmlAttribute(srcOut)}/adapter/${itemClass}Adapter.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/adapter/${itemClass}Adapter.java" />

	<!-- 生成Fragment 文件-->
    <instantiate from="src/app_package/Fragment.java.ftl"                       to="${escapeXmlAttribute(srcOut)}/fragment/${itemClass}Fragment.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/fragment/${itemClass}Fragment.java" />

	<!-- 生成Presenter 文件-->
    <instantiate from="src/app_package/BasePresenter.java.ftl"                       to="${escapeXmlAttribute(srcOut)}/presenter/${itemClass}Presenter.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/presenter/${itemClass}Presenter.java" />

<!-- 生成Contract 文件-->
    <instantiate from="src/app_package/BaseContract.java.ftl"                       to="${escapeXmlAttribute(srcOut)}/presenter/${itemClass}Contract.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/presenter/${itemClass}Contract.java" />

<!-- 生成InteractorImpl 文件-->
    <instantiate from="src/app_package/BaseInteractor.java.ftl"                      to="${escapeXmlAttribute(srcOut)}/interactor/${itemClass}InteractorImpl.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/interactor/${itemClass}Interactor.java" />

<!-- 生成model 文件-->
    <instantiate from="src/app_package/BaseModel.java.ftl"                       to="${escapeXmlAttribute(srcOut)}/model/${itemClass}.java" />
	
    <open file="${escapeXmlAttribute(srcOut)}/model/${itemClass}.java" />

<!-- 生成item布局 文件-->
    <instantiate from="res/layout/item_simple.xml.ftl"           to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
<!-- 生成fragment布局 文件-->
	<instantiate from="res/layout/fragment_simple.xml.ftl"            to="${escapeXmlAttribute(resOut)}/layout/${fragment_layoutName}.xml" />
</recipe>

```

**template.xml    模板的配置信息,以及要输入的参数.定义了模板的流程框架 基本结构**

```
<?xml version="1.0"?>
<template
    format="4"
    revision="1"
    name="ListFragmentAchieve"
    description="Creates a new ListFragmentAchieve"
    minApi="7"
    minBuildApi="14">

    <category value="ListFragmentAchieveName" />

	<!--  <parameter
        id="adapterClass"
        name="Adapter Name"
        type="string"
        constraints="class|unique|nonempty"
        default="CustomAdapter"
        help="The name of the adapter class to create" /> -->
	
	<parameter
        id="itemClass"
        name="Item Name"
        type="string"
        constraints="class|nonempty"
        default="String"
        help="The name of the item class to use" />

    <parameter
        id="layoutName"
        name="item_layout"
        type="string"
        constraints="layout|nonempty"
        default="item_layout"
        help="The name of the row layout to use" />

	<!-- fragment 类文件名称 后来使用 itemClass 拼接完成了-->
    <!-- <parameter
        id="fragmentClass"
        name="fragment Name"
        type="string"
        constraints="class|unique|nonempty"
        default="Fragment"
        help="The name of the fragment class to create" /> -->
	
	<!-- fragment 布局文件名 -->
    <parameter
        id="fragment_layoutName"
        name="fragment_layout"
        type="string"
        constraints="layout|nonempty"
        default="fragment_layout"
        help="The name of the row layout to use" />
		
   
    <!-- 128x128 thumbnails relative to template.xml -->
    <thumbs>
        <!-- default thumbnail is required -->
        <thumb>template_basic_activity_fragment.png</thumb>
    </thumbs>


    <globals file="globals.xml.ftl" />
    <execute file="recipe.xml.ftl" />

</template>
```

剩下的模板资源文件就不一一列举贴代码了 ，这些文件大家可以根据自己的需求去自己定义。

.![剩余的资源文件](http://img.blog.csdn.net/20160528233055573)

效果图：
![这里写图片描述](http://img.blog.csdn.net/20160528234105102)

代码上传到了github:
https://github.com/zhaodaizheng/AndroidTemplates

这个demo自动生成的文件，是根据我自己的框架生成的，大家本地生成后的文件肯定会出现错误，大家可以根据自己封装的框架进行修改。

对FreeMarker不太了解  有错误的地方欢迎反馈。


