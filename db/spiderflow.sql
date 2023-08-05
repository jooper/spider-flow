SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE spiderflow;
USE spiderflow;

DROP TABLE IF EXISTS `sp_flow`;
CREATE TABLE `sp_flow` (
  `id` varchar(32) NOT NULL,
  `name` varchar(64) DEFAULT NULL COMMENT '任务名字',
  `xml` longtext DEFAULT NULL COMMENT 'xml表达式',
  `cron` varchar(255) DEFAULT NULL COMMENT 'corn表达式',
  `enabled` char(1) DEFAULT '0' COMMENT '任务是否启动,默认未启动',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `last_execute_time` datetime DEFAULT NULL  COMMENT '上一次执行时间',
  `next_execute_time` datetime DEFAULT NULL   COMMENT '下一次执行时间',
  `execute_count` int(8) DEFAULT NULL  COMMENT '定时执行的已执行次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '爬虫任务表';


DROP TABLE IF EXISTS `sp_datasource`;
CREATE TABLE `sp_datasource` (
  `id` varchar(32) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `driver_class_name` varchar(255) DEFAULT NULL,
  `jdbc_url` varchar(255) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `sp_variable`;
CREATE TABLE `sp_variable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '变量名',
  `value` varchar(512) DEFAULT NULL COMMENT '变量值',
  `description` varchar(255) DEFAULT NULL COMMENT '变量描述',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/* v0.3.0 新增 */
DROP TABLE IF EXISTS `sp_task`;
CREATE TABLE `sp_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flow_id` varchar(32) NOT NULL,
  `begin_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/* v0.4.0 新增 */
DROP TABLE IF EXISTS `sp_function`;
CREATE TABLE `sp_function`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '函数名',
  `parameter` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `script` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'js脚本',
  `create_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

/* v0.5.0 新增 */
DROP TABLE IF EXISTS `sp_flow_notice`;
CREATE TABLE `sp_flow_notice` (
  `id` varchar(32) NOT NULL,
  `recipients` varchar(200) DEFAULT NULL COMMENT '收件人',
  `notice_way` char(10) DEFAULT NULL COMMENT '通知方式',
  `start_notice` char(1) DEFAULT '0' COMMENT '流程开始通知:1:开启通知,0:关闭通知',
  `exception_notice` char(1) DEFAULT '0' COMMENT '流程异常通知:1:开启通知,0:关闭通知',
  `end_notice` char(1) DEFAULT '0' COMMENT '流程结束通知:1:开启通知,0:关闭通知',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '爬虫任务通知表';



-- spiderflow.spider_fetch_data_conf definition

CREATE TABLE `spider_fetch_data_conf` (
  `data_source_name` varchar(255) DEFAULT NULL COMMENT '数据源名称',
  `page_url` varchar(255) DEFAULT NULL COMMENT '采集路径',
  `sink_table_name` varchar(255) DEFAULT NULL COMMENT '存储数据表名',
  `get_page_count` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '需要爬取数据页数',
  `type` varchar(255) DEFAULT NULL COMMENT '爬取数据类型',
  `isenable` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否开启爬取 Y是，N否',
  `is_grab_latest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否抓取最新的数据 Y是，N否（抓全部配置的数据这里和get_page_count有关系）',
  `ip_proxy` varchar(255) DEFAULT NULL COMMENT '静态ip代理地址  XXX.XXX.XXX.XXX:XXX',
  `site_num` varchar(100) DEFAULT NULL COMMENT '网站编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('1e3c729dbb644cf19b94f45925d20b2b', '【长江有色金属】-边框-铝价', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【长江有色金属】-边框-铝价&quot;,&quot;submit-strategy&quot;:&quot;random&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="2" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="80" y="69" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="784" y="69" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="430" y="69" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;rss&quot;,&quot;tr&quot;,&quot;tb_nm&quot;,&quot;lv&quot;,&quot;name&quot;,&quot;range_price&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;,&quot;get_dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.html}&quot;,&quot;${rss.xpath(&#39;//*[@id=\\&quot;quoPrice_box\\&quot;]/table[1]/tbody&#39;).selectors(&#39;tr&#39;)}&quot;,&quot;${rs[0].sink_table_name}&quot;,&quot;${list.filterStr(tr,&#39;.*A00铝.*&#39;)}&quot;,&quot;${lv[0].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${lv[0].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${lv[0].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${lv[0].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${lv[0].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${lv[0].selectors(&#39;td&#39;)[5].text()}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="Selenium" style="selenium" parent="1" vertex="1">
      <mxGeometry x="290" y="69" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;Selenium&quot;,&quot;nodeVariableName&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;pageLoadTimeout&quot;:&quot;&quot;,&quot;implicitlyWaitTimeout&quot;:&quot;&quot;,&quot;driverType&quot;:&quot;chrome&quot;,&quot;window-size&quot;:&quot;&quot;,&quot;user-agent&quot;:&quot;&quot;,&quot;arguments&quot;:&quot;&quot;,&quot;url&quot;:&quot;${rs[0].page_url}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;headless&quot;:&quot;0&quot;,&quot;javascript-disabled&quot;:&quot;0&quot;,&quot;image-disabled&quot;:&quot;0&quot;,&quot;plugin-disable&quot;:&quot;1&quot;,&quot;java-disable&quot;:&quot;1&quot;,&quot;incognito&quot;:&quot;0&quot;,&quot;sandbox&quot;:&quot;0&quot;,&quot;hide-scrollbar&quot;:&quot;0&quot;,&quot;maximized&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;selenium&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="8" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="16" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="604" y="69" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;GBK&quot;,&quot;output-name&quot;:[&quot;name &quot;,&quot;lvv&quot;,&quot;lv&quot;,&quot;up_down_price&quot;,&quot;uni&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${range_price}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${dt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="17" value="" style="strokeWidth=2;sharp=1;" parent="1" source="8" target="16" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="18" value="" style="strokeWidth=2;sharp=1;" parent="1" source="16" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="执行SQL" style="executeSql" vertex="1" parent="1">
      <mxGeometry x="160" y="69" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行SQL&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;边框&#39; and \\nisenable=&#39;Y&#39;\\nand site_num=14&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" edge="1" parent="1" source="2" target="19">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="" style="strokeWidth=2;sharp=1;" edge="1" parent="1" source="19" target="11">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="23" value="执行SQL" style="executeSql" vertex="1" parent="1">
      <mxGeometry x="604" y="148" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行SQL&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt,site_num)\\nVALUES(#${name}#, #${range_price}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${dt}#, #${get_dt}#,14);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="25" value="" style="strokeWidth=2;sharp=1;" edge="1" parent="1" source="23" target="5">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="执行SQL" style="executeSql" vertex="1" parent="1">
      <mxGeometry x="430" y="240" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行SQL&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\nsite_num=14 and \\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="29" value="" style="strokeWidth=2;strokeColor=blue;sharp=1;" edge="1" parent="1" source="8" target="26">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${list.length(lv)&gt;=1}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="30" value="" style="strokeWidth=2;sharp=1;" edge="1" parent="1" source="26" target="23">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-31 06:28:24', NULL, NULL, NULL);

INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('3610d3d50f9941f386db59e472ec10a4', '【有色金属】-DMC价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-DMC价格&quot;,&quot;submit-strategy&quot;:&quot;random&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;DMC&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-18 04:10:32', '2023-07-26 13:35:22', NULL, 1);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('3df16ea8d51648f4895866028806e664', '【有色金属】-硅片价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-硅片价格&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;硅片&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 04:55:31', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('663aaa5e36a84c9594ef3cfd6738e9a7', '百度热点', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;百度热点&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="2" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="80" y="80" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="3" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="220" y="80" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;gbk&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://top.baidu.com/buzz?b=1&amp;fr=topindex&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="360" y="80" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;elementbd&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;//*[@id=\\&quot;main\\&quot;]/div[2]/div/table/tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="480" y="80" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;i&quot;,&quot;output-name&quot;:[&quot;名称&quot;,&quot;地址&quot;,&quot;百度指数&quot;,&quot;2&quot;],&quot;loopCount&quot;:&quot;${elementbd.size()-1}&quot;,&quot;output-value&quot;:[&quot;${elementbd[i+1].xpath(&#39;//td[2]/a[1]/text()&#39;)}&quot;,&quot;${elementbd[i+1].xpath(&#39;//td[2]/a[1]/@href&#39;)}&quot;,&quot;${elementbd[i+1].xpath(&#39;//td[4]/span/text()&#39;)}&quot;,&quot;${elementbd[i+1].xpath(&#39;//td[3]/a[2]/text()&#39;)}&quot;],&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="" parent="1" source="2" target="3" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="" parent="1" source="3" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" parent="1" source="4" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', '0 0/30 * * * ? *', '0', '2019-10-20 17:24:21', '2019-11-04 08:52:05', NULL, 45);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('6a9b2a68425847d4b07b611c15863a13', '【有色金属】-多晶硅价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-多晶硅价格&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;多晶硅&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 03:18:03', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('6bb6419b94134cea98f712db6d3eac49', '【有色金属】-银浆价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-银浆价格&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;银浆&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 04:56:09', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('7f1067b4034042afb0220dc7331ea868', '【有色金属】-光伏胶膜价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-光伏胶膜价格&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;光伏胶膜&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 04:54:34', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('8c96ddeeed2f46299e43ed900be7e0bf', '【有色金属】-SMM（有机硅）价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-SMM（有机硅）价格&quot;,&quot;submit-strategy&quot;:&quot;random&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;61.164.39.67:53281&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;SMM&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-19 08:57:19', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('94be6e6baf8148019f4d747e94e82e5d', '【有色金属】-电池片价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-电池片价格&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;电池片&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 04:52:59', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('a15b42eb56d04b3588fdfbe414cc930f', '【有色金属】-EVA价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-EVA价格&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;EVA&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 03:13:53', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('a760fce37b0447ed86f833c655e60e51', '【有色金属】-光伏玻璃价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-光伏玻璃价格&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;光伏玻璃&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 03:16:22', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('b4430885ba8349588d1220d37eac831d', '爬取开源中国动弹', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;爬取开源中国动弹&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="2" value="开始" style="start" vertex="1" parent="1">
      <mxGeometry x="80" y="80" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="3" value="爬取动弹" style="request" vertex="1" parent="1">
      <mxGeometry x="220" y="80" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取动弹&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;parameter-name&quot;:[&quot;type&quot;,&quot;lastLogId&quot;],&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://www.oschina.net/tweets/widgets/_tweet_index_list &quot;,&quot;proxy&quot;:&quot;&quot;,&quot;parameter-value&quot;:[&quot;ajax&quot;,&quot;NULL&quot;],&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" edge="1" parent="1" source="2" target="3">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="提取lastLogId以及tweets" style="variable" vertex="1" parent="1">
      <mxGeometry x="340" y="80" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;提取lastLogId以及tweets&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;lastLogId&quot;,&quot;tweets&quot;,&quot;fetchCount&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.selector(&#39;.tweet-item:last-child&#39;).attr(&#39;data-tweet-id&#39;)}&quot;,&quot;${resp.selectors(&#39;.tweet-item[data-tweet-id]&#39;)}&quot;,&quot;${fetchCount == null ? 0 : fetchCount + 1}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="" edge="1" parent="1" source="3" target="5">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="循环" style="loop" vertex="1" parent="1">
      <mxGeometry x="340" y="250" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(tweets)}&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" edge="1" parent="1" source="5" target="7">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="9" value="提取详细信息" style="variable" vertex="1" parent="1">
      <mxGeometry x="340" y="340" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;提取详细信息&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;content&quot;,&quot;author&quot;,&quot;like&quot;,&quot;reply&quot;,&quot;publishTime&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${tweets[index].selector(&#39;.text&#39;).text()}&quot;,&quot;${tweets[index].selector(&#39;.user&#39;).text()}&quot;,&quot;${tweets[index].selector(&#39;.like span&#39;).text()}&quot;,&quot;${tweets[index].selector(&#39;.reply span&#39;).text()}&quot;,&quot;${tweets[index].selector(&#39;.date&#39;).regx(&#39;(.*?)&amp;nbsp&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="" edge="1" parent="1" source="7" target="9">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="输出" style="output" vertex="1" parent="1">
      <mxGeometry x="340" y="430" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;output-name&quot;:[&quot;作者&quot;,&quot;内容&quot;,&quot;点赞数&quot;,&quot;评论数&quot;,&quot;发布时间&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;NULL&quot;,&quot;NULL&quot;,&quot;NULL&quot;,&quot;NULL&quot;,&quot;NULL&quot;],&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" edge="1" parent="1" source="9" target="11">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="爬取3页" edge="1" parent="1" source="5" target="3">
      <mxGeometry x="-0.0312" y="-20" relative="1" as="geometry">
        <Array as="points">
          <mxPoint x="356" y="180"/>
          <mxPoint x="236" y="180"/>
        </Array>
        <mxPoint as="offset"/>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取5页&quot;,&quot;condition&quot;:&quot;${fetchCount &lt; 3}&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', '', '0', '2019-11-03 17:02:49', '2019-11-04 10:11:31', NULL, 3);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('b45fb98d2a564c23ba623a377d5e12e9', '爬取码云GVP', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;爬取码云GVP&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="2" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="80" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="抓取首页" style="request" parent="1" vertex="1">
      <mxGeometry x="180" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;抓取首页&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://gitee.com/gvp/all&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:[&quot;&quot;],&quot;follow-redirect&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="" parent="1" source="2" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="提取项目名、地址" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;提取项目名、地址&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;projectUrls&quot;,&quot;projectNames&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${extract.selectors(resp.html,&#39;.categorical-project-card a&#39;,&#39;attr&#39;,&#39;href&#39;)}&quot;,&quot;${extract.selectors(resp.html,&#39;.project-name&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" parent="1" source="5" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="9" value="抓取详情页" style="request" parent="1" vertex="1">
      <mxGeometry x="450.16668701171875" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;抓取详情页&quot;,&quot;loopVariableName&quot;:&quot;projectIndex&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;10&quot;,&quot;url&quot;:&quot;https://gitee.com/${projectUrls[projectIndex]}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:[&quot;&quot;],&quot;follow-redirect&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="" parent="1" source="7" target="9" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="提取项目描述" style="variable" parent="1" vertex="1">
      <mxGeometry x="550" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;提取项目描述&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;projectDesc&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${extract.selector(resp.html,&#39;.git-project-desc-text&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" parent="1" source="9" target="12" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="660.1666870117188" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;output-name&quot;:[&quot;项目名&quot;,&quot;项目地址&quot;,&quot;项目描述&quot;],&quot;output-value&quot;:[&quot;${projectNames[projectIndex]}&quot;,&quot;https://gitee.com${projectUrls[projectIndex]}&quot;,&quot;NULL&quot;],&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="15" value="" parent="1" source="12" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2019-08-22 13:46:54', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('b870bab9954a421eab5122bafaacd0b7', '【有色金属】-价格数据采集-DI', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-价格数据采集-DI&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\n-- type=&#39;硅粉&#39; and\\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 04:48:55', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('c925bacae2a24477a9903edcab8e49f9', '【有色金属】-光伏边框-DF', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-光伏边框-DF&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="362" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\nsite_num=4 and \\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt,site_num)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#,4);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;光伏边框&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 04:53:43', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('cb8be3531cd24e5198f00a11ec492e8d', '公众号', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;公众号&quot;,&quot;submit-strategy&quot;:&quot;random&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="2" value="开始" style="start" vertex="1" parent="1">
      <mxGeometry x="80" y="80" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="3" value="Selenium" style="selenium" vertex="1" parent="1">
      <mxGeometry x="230" y="90" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;Selenium&quot;,&quot;nodeVariableName&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;pageLoadTimeout&quot;:&quot;&quot;,&quot;implicitlyWaitTimeout&quot;:&quot;&quot;,&quot;driverType&quot;:&quot;chrome&quot;,&quot;window-size&quot;:&quot;&quot;,&quot;user-agent&quot;:&quot;&quot;,&quot;arguments&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://mp.weixin.qq.com/s/XWu3s9BFSD_9ZzIv3Qnzmg&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;headless&quot;:&quot;0&quot;,&quot;javascript-disabled&quot;:&quot;0&quot;,&quot;image-disabled&quot;:&quot;0&quot;,&quot;plugin-disable&quot;:&quot;1&quot;,&quot;java-disable&quot;:&quot;1&quot;,&quot;incognito&quot;:&quot;0&quot;,&quot;sandbox&quot;:&quot;0&quot;,&quot;hide-scrollbar&quot;:&quot;0&quot;,&quot;maximized&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;selenium&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="strokeWidth=2;sharp=1;" edge="1" parent="1" source="2" target="3">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="定义变量" style="variable" vertex="1" parent="1">
      <mxGeometry x="340" y="96" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;rs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.html}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="" style="strokeWidth=2;sharp=1;" edge="1" parent="1" source="3" target="5">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="执行结束" style="forkJoin" vertex="1" parent="1">
      <mxGeometry x="470" y="100" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" edge="1" parent="1" source="5" target="7">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-31 06:12:00', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('ce9d0a420bde44b28b55feacbc9e06dd', '【有色金属】-组件价格-DF', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【有色金属】-组件价格-DF&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="30" y="212" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="440" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}?page=${page}&quot;,&quot;proxy&quot;:&quot;${ip_proxy}&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1448" y="276" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="552" y="173" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;xxx&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${sink_tb}&quot;,&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.xpath(&#39;/html/body/div[1]/div[2]/div/div[3]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;^.*(2023-07-17).*$&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1238" y="178" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${name}&quot;,&quot;${price_range}&quot;,&quot;${avg_price}&quot;,&quot;${up_down_price}&quot;,&quot;${unit}&quot;,&quot;${subDt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="678" y="173" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1058" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;name&quot;,&quot;price_range&quot;,&quot;avg_price&quot;,&quot;up_down_price&quot;,&quot;unit&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;)[0].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[2].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="获取具体每项值" style="variable" parent="1" vertex="1">
      <mxGeometry x="678" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取具体每项值&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;subTitle&quot;,&quot;subHref&quot;,&quot;subDt&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].selector(&#39;a&#39;).text()}&quot;,&quot;https://hq.smm.cn${proList[index].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${proList[index].selector(&#39;span&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="554" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1238" y="353" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.${tb_nm}\\n(name, price_range, avg_price, up_down_price, unit, dt, get_dt)\\nVALUES(#${name}#, #${price_range}#, #${avg_price}#, #${up_down_price}#, #${unit}#, #${subDt}#, #${get_dt}#);\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="26" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="828" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;${subHref}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="28" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="26" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="828" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;],&quot;variable-description&quot;:[&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="32" value="" style="strokeWidth=2;sharp=1;" parent="1" source="26" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="33" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="928" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="34" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="33" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="35" value="" style="strokeWidth=2;sharp=1;" parent="1" source="33" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="38" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="41" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="4" edge="1">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="578" y="231" as="sourcePoint"/>
        <mxPoint x="472" y="221" as="targetPoint"/>
        <Array as="points">
          <mxPoint x="570" y="251"/>
          <mxPoint x="456" y="251"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="130" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;组件&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="330" y="50" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;ip_proxy&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;${rs[ix].ip_proxy}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="47" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="210" y="308" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="51" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 02:21:06', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('d2ab45c698f64ce49540cd059e7758dc', 'PV', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;PV&quot;,&quot;submit-strategy&quot;:&quot;random&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="150" y="128" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" style="request" parent="1" vertex="1">
      <mxGeometry x="242" y="128" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;retryCount&quot;:&quot;&quot;,&quot;retryInterval&quot;:&quot;&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://www.infolink-group.com/spot-price/cn&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;repeat-enable&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1450" y="269" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="354" y="128" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;title&quot;,&quot;proList&quot;,&quot;dt&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${extract.regx(resp.html,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${resp.selectors(&#39;table&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd HH:mm&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="1240" y="171" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;UTF-8&quot;,&quot;output-name&quot;:[&quot;类别&quot;,&quot;项目&quot;,&quot;高点&quot;,&quot;低点&quot;,&quot;均价&quot;,&quot;涨跌幅&quot;,&quot;涨跌幅&quot;,&quot;下周价格预测&quot;,&quot;dt&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${catalog}&quot;,&quot;${项目}&quot;,&quot;${高点}&quot;,&quot;${低点}&quot;,&quot;${均价}&quot;,&quot;${涨跌幅1}&quot;,&quot;${涨跌幅2}&quot;,&quot;${下周价格预测}&quot;,&quot;${dt}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" style="strokeWidth=2;sharp=1;" parent="1" source="4" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="9" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="4" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="10" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="570" y="128" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="11" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="1060" y="253" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;项目&quot;,&quot;高点&quot;,&quot;低点&quot;,&quot;均价&quot;,&quot;涨跌幅1&quot;,&quot;涨跌幅2&quot;,&quot;下周价格预测&quot;,&quot;catalog&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${trs[trindex].selectors(&#39;td&#39;).texts()[0]}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[1].text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;).texts()[2]}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[3].html()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[4].selector(&#39;span&#39;).text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[5].selector(&#39;span&#39;).text()}&quot;,&quot;${trs[trindex].selectors(&#39;td&#39;)[6].selector(&#39;span&#39;).text()}&quot;,&quot;${catalog}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="12" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="13" value="" style="strokeWidth=2;sharp=1;" parent="1" source="7" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="14" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="690" y="253" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;trs&quot;,&quot;catalog&quot;,&quot;alll&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[index].xpaths(&#39;tbody/tr&#39;)}&quot;,&quot;${proList[index].selector(&#39;caption&#39;).text()}&quot;,&quot;${proList[index].html()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="15" value="" style="strokeWidth=2;sharp=1;" parent="1" source="10" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="16" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="888" y="253" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;trindex&quot;,&quot;loopCount&quot;:&quot;${list.length(trs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="17" value="" style="strokeWidth=2;sharp=1;" parent="1" source="14" target="16" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="18" value="" style="strokeWidth=2;sharp=1;" parent="1" source="16" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="356" y="340" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.pv_gf_market_price where dt=#${dt}#; \\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="21" value="入库采集到的最新数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="1240" y="346" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;入库采集到的最新数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;insert&quot;,&quot;sql&quot;:&quot;INSERT INTO spidered_data.pv_gf_market_price\\n(catalog,pro_nm, hight_point, lower_point, avg_price, up_rate_percent, up_rate_dollar, next_week_price, dt)\\nVALUES(#${catalog}#,#${项目}#,#${高点}#,#${低点}#,#${均价}#,#${涨跌幅1}#,#${涨跌幅2}#,#${下周价格预测}#,#${dt}#);&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="22" value="" style="strokeWidth=2;sharp=1;" parent="1" source="21" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="23" value="" style="strokeWidth=2;sharp=1;" parent="1" source="19" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="24" value="" style="strokeWidth=2;sharp=1;" parent="1" source="11" target="21" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-17 01:28:08', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('f0a67f17ee1a498a9b2f4ca30556f3c3', '抓取每日菜价', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;抓取每日菜价&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="2" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="80" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="3" value="开始抓取" style="request" parent="1" vertex="1">
      <mxGeometry x="219.83334350585938" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;http://www.beijingprice.cn:8086/price/priceToday/PageLoad/LoadPrice?jsoncallback=1&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:[&quot;&quot;],&quot;follow-redirect&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="4" value="" parent="1" source="2" target="3" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="解析JSON" style="variable" parent="1" vertex="1">
      <mxGeometry x="350" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;解析JSON&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;jsonstr&quot;,&quot;jsondata&quot;,&quot;data&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${string.substring(resp.html,2,resp.html.length()-1)}&quot;,&quot;${json.parse(jsonstr)}&quot;,&quot;${extract.jsonpath(jsondata[0],&#39;data&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="" parent="1" source="3" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="7" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="480.16668701171875" y="80" width="24" height="24" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;i&quot;,&quot;output-name&quot;:[&quot;菜名&quot;,&quot;菜价&quot;,&quot;单位&quot;],&quot;loopCount&quot;:&quot;${list.length(data)}&quot;,&quot;output-value&quot;:[&quot;${data[i].ItemName}&quot;,&quot;${data[i].Price04}&quot;,&quot;${data[i].ItemUnit}&quot;],&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="8" value="" parent="1" source="5" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2019-08-22 13:48:22', NULL, NULL, NULL);
INSERT INTO spiderflow.sp_flow
(id, name, xml, cron, enabled, create_date, last_execute_time, next_execute_time, execute_count)
VALUES('f8245621734f4b74bcb0ab3357991eb2', '【东方财富网】-铜-价格', '<mxGraphModel>
  <root>
    <mxCell id="0">
      <JsonProperty as="data">
        {&quot;spiderName&quot;:&quot;【东方财富网】-铜-价格&quot;,&quot;submit-strategy&quot;:&quot;linked&quot;,&quot;threadCount&quot;:&quot;&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="1" parent="0"/>
    <mxCell id="3" value="开始" style="start" parent="1" vertex="1">
      <mxGeometry x="20" y="220" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;shape&quot;:&quot;start&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="5" value="执行结束" style="forkJoin" parent="1" vertex="1">
      <mxGeometry x="1020" y="354" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;执行结束&quot;,&quot;shape&quot;:&quot;forkJoin&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="6" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="318" y="333" width="36" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;res&quot;,&quot;tb_nm&quot;,&quot;title&quot;,&quot;proList&quot;,&quot;get_dt&quot;,&quot;page&quot;,&quot;proList&quot;,&quot;s_2309_href&quot;,&quot;fs&quot;,&quot;c_url&quot;,&quot;c_title&quot;,&quot;proList&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;获取2309价格&quot;,&quot;获取主连项目&quot;,&quot;&quot;,&quot;&quot;,&quot;除了主连页的其他地址&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.html}&quot;,&quot;${sink_tb}&quot;,&quot;${extract.regx(res,&#39;&lt;title&gt;(.*?)&lt;/title&gt;&#39;)}&quot;,&quot;${res.xpath(&#39;//*[@id=\\&quot;stock_type_FU_OR_OP\\&quot;]/ul&#39;).selectors(&#39;li&#39;)}&quot;,&quot;${date.format(date.now(),&#39;yyyy-MM-dd&#39;)}&quot;,&quot;${page==null ? 1 : (page + 1)}&quot;,&quot;${is_grab_latest==&#39;Y&#39;?list.sublist(proList,0,1):proList}&quot;,&quot;${list.filterStr(proList,&#39;.*113\\\\\\\\.cu2309.*&#39;)[0].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${list.filterStr(proList,&#39;.*cum.*&#39;)}&quot;,&quot;${fs[0].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${fs[0].selector(&#39;a&#39;).text()}&quot;,&quot;${list.filterStr(proList,&#39;.*113\\\\\\\\.cu.*&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="19" value="清空相应分钟数据" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="320" y="513" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;清空相应分钟数据&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;delete&quot;,&quot;sql&quot;:&quot;delete from spidered_data.${tb_nm} where\\ncase when &#39;${is_grab_latest}&#39;=&#39;Y&#39; then \\ndt=#${get_dt}#\\nelse\\nget_dt=#${get_dt}#\\nend\\n\\n&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="20" value="" style="strokeWidth=2;sharp=1;" parent="1" source="6" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="31" value="获取沪铜主连价格" style="variable" parent="1" vertex="1">
      <mxGeometry x="436" y="513" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取沪铜主连价格&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;c_url&quot;,&quot;m_title&quot;,&quot;m_price&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${c_url}&quot;,&quot;${resp.xpath(\\&quot;/html/body/div[1]/div/div/div[7]/div/div[1]/span[1]\\&quot;).text()}&quot;,&quot;${resp.xpath(\\&quot;/html/body/div[1]/div/div/div[8]/div[1]/div/div[1]/span[1]/span\\&quot;).text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="42" value="获取爬取配置" style="executeSql" parent="1" vertex="1">
      <mxGeometry x="20" y="436" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;获取爬取配置&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;statementType&quot;:&quot;select&quot;,&quot;sql&quot;:&quot;SELECT * from spiderflow.spider_fetch_data_conf \\nwhere \\ntype=&#39;copper&#39; and \\nisenable=&#39;Y&#39;&quot;,&quot;isStream&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;executeSql&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="43" value="" style="strokeWidth=2;sharp=1;" parent="1" source="3" target="42" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="45" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="96" y="210" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;conf&quot;,&quot;page_url&quot;,&quot;sink_tb&quot;,&quot;need_get_page_cnt&quot;,&quot;is_grab_latest&quot;,&quot;page&quot;],&quot;variable-description&quot;:[&quot;获取爬取配置信息&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rs[ix]}&quot;,&quot;${rs[ix].page_url}&quot;,&quot;${rs[ix].sink_table_name}&quot;,&quot;${rs[ix].get_page_count}&quot;,&quot;${rs[ix].is_grab_latest}&quot;,&quot;1&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="48" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="96" y="436" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;ix&quot;,&quot;loopCount&quot;:&quot;${list.length(rs)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="49" value="" style="strokeWidth=2;sharp=1;" parent="1" source="42" target="48" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="50" value="" style="strokeWidth=2;sharp=1;" parent="1" source="48" target="45" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="52" value="Selenium" style="selenium" parent="1" vertex="1">
      <mxGeometry x="156" y="333" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;Selenium&quot;,&quot;nodeVariableName&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;pageLoadTimeout&quot;:&quot;&quot;,&quot;implicitlyWaitTimeout&quot;:&quot;&quot;,&quot;driverType&quot;:&quot;chrome&quot;,&quot;window-size&quot;:&quot;&quot;,&quot;user-agent&quot;:&quot;&quot;,&quot;arguments&quot;:&quot;&quot;,&quot;url&quot;:&quot;${page_url}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;headless&quot;:&quot;0&quot;,&quot;javascript-disabled&quot;:&quot;0&quot;,&quot;image-disabled&quot;:&quot;0&quot;,&quot;plugin-disable&quot;:&quot;1&quot;,&quot;java-disable&quot;:&quot;1&quot;,&quot;incognito&quot;:&quot;0&quot;,&quot;sandbox&quot;:&quot;0&quot;,&quot;hide-scrollbar&quot;:&quot;0&quot;,&quot;maximized&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;selenium&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="53" value="" style="strokeWidth=2;sharp=1;" parent="1" source="45" target="52" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="54" value="爬取N页" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="52" edge="1">
      <mxGeometry relative="1" as="geometry">
        <Array as="points">
          <mxPoint x="336" y="400"/>
          <mxPoint x="182" y="400"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;爬取N页&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${page}&lt;${need_get_page_cnt}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="55" value="" style="strokeWidth=2;sharp=1;" parent="1" source="52" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="59" value="Selenium" style="selenium" parent="1" vertex="1">
      <mxGeometry x="436" y="333" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;Selenium&quot;,&quot;nodeVariableName&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;pageLoadTimeout&quot;:&quot;&quot;,&quot;implicitlyWaitTimeout&quot;:&quot;&quot;,&quot;driverType&quot;:&quot;chrome&quot;,&quot;window-size&quot;:&quot;&quot;,&quot;user-agent&quot;:&quot;&quot;,&quot;arguments&quot;:&quot;&quot;,&quot;url&quot;:&quot;${c_url}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;headless&quot;:&quot;0&quot;,&quot;javascript-disabled&quot;:&quot;0&quot;,&quot;image-disabled&quot;:&quot;0&quot;,&quot;plugin-disable&quot;:&quot;1&quot;,&quot;java-disable&quot;:&quot;1&quot;,&quot;incognito&quot;:&quot;0&quot;,&quot;sandbox&quot;:&quot;0&quot;,&quot;hide-scrollbar&quot;:&quot;0&quot;,&quot;maximized&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;selenium&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="63" value="" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="6" target="59" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${c_url!=\\&quot;\\&quot;}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="64" value="" style="strokeWidth=2;sharp=1;" parent="1" source="59" target="31" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="83" value="Selenium" style="selenium" parent="1" vertex="1">
      <mxGeometry x="536" y="513" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;Selenium&quot;,&quot;nodeVariableName&quot;:&quot;resp2&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;pageLoadTimeout&quot;:&quot;&quot;,&quot;implicitlyWaitTimeout&quot;:&quot;&quot;,&quot;driverType&quot;:&quot;chrome&quot;,&quot;window-size&quot;:&quot;&quot;,&quot;user-agent&quot;:&quot;&quot;,&quot;arguments&quot;:&quot;&quot;,&quot;url&quot;:&quot;http://quote.eastmoney.com/qihuo/cu2309.html&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;headless&quot;:&quot;0&quot;,&quot;javascript-disabled&quot;:&quot;0&quot;,&quot;image-disabled&quot;:&quot;0&quot;,&quot;plugin-disable&quot;:&quot;1&quot;,&quot;java-disable&quot;:&quot;1&quot;,&quot;incognito&quot;:&quot;0&quot;,&quot;sandbox&quot;:&quot;0&quot;,&quot;hide-scrollbar&quot;:&quot;0&quot;,&quot;maximized&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;selenium&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="86" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="536" y="322" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;s_price&quot;,&quot;s_title&quot;,&quot;s_code&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp2.xpath(\\&quot;/html/body/div[1]/div/div/div[8]/div[1]/div/div[1]/span[1]/span\\&quot;).text()}&quot;,&quot;${resp2.xpath(\\&quot;/html/body/div[1]/div/div/div[7]/div/div[1]/span[1]\\&quot;).text()}&quot;,&quot;${string.upper(resp2.xpath(\\&quot;/html/body/div[1]/div/div/div[7]/div/div[1]/span[2]\\&quot;).text())}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="87" value="" style="strokeWidth=2;sharp=1;" parent="1" source="83" target="86" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="98" value="" style="strokeWidth=2;sharp=1;" parent="1" source="31" target="83" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="100" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="786" y="310" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;GBK&quot;,&quot;output-name&quot;:[&quot;s&quot;,&quot;st&quot;,&quot;m&quot;,&quot;mt&quot;,&quot;s_code&quot;,&quot;cooper_dt&quot;,&quot;copper_price&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${s_price}&quot;,&quot;${s_title}&quot;,&quot;${m_title}&quot;,&quot;${m_price}&quot;,&quot;${s_code}&quot;,&quot;${cooper_dt}&quot;,&quot;${copper_price}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="101" value="判断是否等于预制期货" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="86" target="114" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;判断是否等于预制期货&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${s_price==m_price}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="102" value="" style="strokeWidth=2;sharp=1;" parent="1" source="100" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="110" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="656" y="497" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;rs&quot;,&quot;cooper_dt&quot;,&quot;copper_price&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.html}&quot;,&quot;${rs.xpath(&#39;//*[@id=\\&quot;tabBody\\&quot;]/tr[1]/td[1]&#39;).selector(&#39;td&#39;).text()}&quot;,&quot;${rs.xpath(&#39;//*[@id=\\&quot;tabBody\\&quot;]/tr[1]/td[2]&#39;).selector(&#39;td&#39;).text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="112" value="" style="strokeWidth=2;sharp=1;" parent="1" source="110" target="100" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="114" value="Selenium" style="selenium" parent="1" vertex="1">
      <mxGeometry x="656" y="322" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;Selenium&quot;,&quot;nodeVariableName&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;pageLoadTimeout&quot;:&quot;&quot;,&quot;implicitlyWaitTimeout&quot;:&quot;&quot;,&quot;driverType&quot;:&quot;chrome&quot;,&quot;window-size&quot;:&quot;&quot;,&quot;user-agent&quot;:&quot;&quot;,&quot;arguments&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://data.eastmoney.com/futures/sh/timeline.html?ex=069001005&amp;va=CU&amp;ct=${s_code}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;headless&quot;:&quot;0&quot;,&quot;javascript-disabled&quot;:&quot;0&quot;,&quot;image-disabled&quot;:&quot;0&quot;,&quot;plugin-disable&quot;:&quot;1&quot;,&quot;java-disable&quot;:&quot;1&quot;,&quot;incognito&quot;:&quot;0&quot;,&quot;sandbox&quot;:&quot;0&quot;,&quot;hide-scrollbar&quot;:&quot;0&quot;,&quot;maximized&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;selenium&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="115" value="" style="strokeWidth=2;sharp=1;" parent="1" source="114" target="110" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="116" value="循环" style="loop" parent="1" vertex="1">
      <mxGeometry x="586" y="194" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;循环&quot;,&quot;loopItem&quot;:&quot;&quot;,&quot;loopVariableName&quot;:&quot;indx&quot;,&quot;loopCount&quot;:&quot;${list.length(proList)}&quot;,&quot;loopStart&quot;:&quot;0&quot;,&quot;loopEnd&quot;:&quot;-1&quot;,&quot;shape&quot;:&quot;loop&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="117" value="不等预制则循环查找等价的期货" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="86" target="116" edge="1">
      <mxGeometry relative="1" as="geometry">
        <Array as="points">
          <mxPoint x="556" y="210"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;不等预制则循环查找等价的期货&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${s_price!=m_price &amp;&amp; 1==2}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="118" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="586" y="74" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;o_url&quot;,&quot;m_price&quot;,&quot;s_price&quot;],&quot;variable-description&quot;:[&quot;获取路径&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${proList[indx].selector(&#39;a&#39;).attr(&#39;href&#39;)}&quot;,&quot;${m_price}&quot;,&quot;${s_price}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="119" value="" style="strokeWidth=2;sharp=1;" parent="1" source="116" target="118" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="120" value="Selenium" style="selenium" parent="1" vertex="1">
      <mxGeometry x="700" y="74" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;Selenium&quot;,&quot;nodeVariableName&quot;:&quot;rp1&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;pageLoadTimeout&quot;:&quot;&quot;,&quot;implicitlyWaitTimeout&quot;:&quot;&quot;,&quot;driverType&quot;:&quot;chrome&quot;,&quot;window-size&quot;:&quot;&quot;,&quot;user-agent&quot;:&quot;&quot;,&quot;arguments&quot;:&quot;&quot;,&quot;url&quot;:&quot;${o_url}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;headless&quot;:&quot;0&quot;,&quot;javascript-disabled&quot;:&quot;0&quot;,&quot;image-disabled&quot;:&quot;0&quot;,&quot;plugin-disable&quot;:&quot;1&quot;,&quot;java-disable&quot;:&quot;1&quot;,&quot;incognito&quot;:&quot;0&quot;,&quot;sandbox&quot;:&quot;0&quot;,&quot;hide-scrollbar&quot;:&quot;0&quot;,&quot;maximized&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;selenium&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="121" value="" style="strokeWidth=2;sharp=1;" parent="1" source="118" target="120" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="122" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="700" y="194" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;o_price&quot;,&quot;o_code&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${rp1.xpath(\\&quot;/html/body/div[1]/div/div/div[8]/div[1]/div/div[1]/span[1]/span\\&quot;).text()}&quot;,&quot;${rp1.xpath(\\&quot;/html/body/div[1]/div/div/div[7]/div/div[1]/span[2]\\&quot;).text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="123" value="" style="strokeWidth=2;sharp=1;" parent="1" source="120" target="122" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="124" value="" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="122" target="120" edge="1">
      <mxGeometry relative="1" as="geometry">
        <Array as="points">
          <mxPoint x="800" y="210"/>
          <mxPoint x="800" y="90"/>
        </Array>
      </mxGeometry>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${o_price!=m_price}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="126" value="" style="strokeWidth=2;strokeColor=blue;sharp=1;" parent="1" source="122" target="127" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;blue&quot;,&quot;condition&quot;:&quot;${o_price==m_price}&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="127" value="Selenium" style="selenium" parent="1" vertex="1">
      <mxGeometry x="880" y="194" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;Selenium&quot;,&quot;nodeVariableName&quot;:&quot;rp2&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;pageLoadTimeout&quot;:&quot;&quot;,&quot;implicitlyWaitTimeout&quot;:&quot;&quot;,&quot;driverType&quot;:&quot;chrome&quot;,&quot;window-size&quot;:&quot;&quot;,&quot;user-agent&quot;:&quot;&quot;,&quot;arguments&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://data.eastmoney.com/futures/sh/timeline.html?ex=069001005&amp;va=CU&amp;ct=${o_code}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;cookie-auto-set&quot;:&quot;1&quot;,&quot;headless&quot;:&quot;0&quot;,&quot;javascript-disabled&quot;:&quot;0&quot;,&quot;image-disabled&quot;:&quot;0&quot;,&quot;plugin-disable&quot;:&quot;1&quot;,&quot;java-disable&quot;:&quot;1&quot;,&quot;incognito&quot;:&quot;0&quot;,&quot;sandbox&quot;:&quot;0&quot;,&quot;hide-scrollbar&quot;:&quot;0&quot;,&quot;maximized&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;selenium&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="129" value="定义变量" style="variable" parent="1" vertex="1">
      <mxGeometry x="880" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;rp2&quot;,&quot;o_dt&quot;,&quot;o_price&quot;],&quot;variable-description&quot;:[&quot;&quot;,&quot;&quot;,&quot;&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.html}&quot;,&quot;${rp2.xpath(&#39;//*[@id=\\&quot;tabBody\\&quot;]/tr[1]/td[1]&#39;).selector(&#39;td&#39;).text()}&quot;,&quot;${rp2.xpath(&#39;//*[@id=\\&quot;tabBody\\&quot;]/tr[1]/td[2]&#39;).selector(&#39;td&#39;).text()}&quot;],&quot;shape&quot;:&quot;variable&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="130" value="" style="strokeWidth=2;sharp=1;" parent="1" source="127" target="129" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="131" value="输出" style="output" parent="1" vertex="1">
      <mxGeometry x="972" y="260" width="32" height="32" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;datasourceId&quot;:&quot;17224e82e095c7b51df15cee83954569&quot;,&quot;tableName&quot;:&quot;&quot;,&quot;csvName&quot;:&quot;&quot;,&quot;csvEncoding&quot;:&quot;GBK&quot;,&quot;output-name&quot;:[&quot;o_dt&quot;,&quot;o_price&quot;,&quot;m_title&quot;,&quot;m_pric&quot;,&quot;s_pric&quot;,&quot;s_title&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${o_dt}&quot;,&quot;${o_price}&quot;,&quot;${m_title}&quot;,&quot;${m_price}&quot;,&quot;${s_pric}&quot;,&quot;${s_title}&quot;],&quot;output-all&quot;:&quot;0&quot;,&quot;output-database&quot;:&quot;0&quot;,&quot;output-csv&quot;:&quot;0&quot;,&quot;shape&quot;:&quot;output&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="132" value="" style="strokeWidth=2;sharp=1;" parent="1" source="129" target="131" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
    <mxCell id="133" value="" style="strokeWidth=2;sharp=1;" parent="1" source="131" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
      <JsonProperty as="data">
        {&quot;value&quot;:&quot;&quot;,&quot;exception-flow&quot;:&quot;0&quot;,&quot;lineWidth&quot;:&quot;2&quot;,&quot;line-style&quot;:&quot;sharp&quot;,&quot;lineColor&quot;:&quot;black&quot;,&quot;condition&quot;:&quot;&quot;,&quot;transmit-variable&quot;:&quot;1&quot;}
      </JsonProperty>
    </mxCell>
  </root>
</mxGraphModel>
', NULL, '0', '2023-07-26 08:49:43', NULL, NULL, NULL);

INSERT INTO spiderflow.sp_datasource
(id, name, driver_class_name, jdbc_url, username, password, create_date)
VALUES('17224e82e095c7b51df15cee83954569', 'mysql', 'com.mysql.jdbc.Driver', 'jdbc:mysql://172.20.211.47:3306/spiderflow?useSSL=false&useUnicode=true&characterEncoding=UTF8&autoReconnect=true', 'root', 'QHxixsr52h0UbeKm5wwuIMBwrl0DcodP', '2023-07-17 01:58:11');


INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/12638', 'module_price', '2', '组件', 'Y', 'Y', '117.64.224.153:9999', '1');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/12636', 'battery_piece_price', '2', '电池片', 'Y', 'Y', NULL, '2');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/13774', 'eva_price', '2', 'EVA', 'Y', 'Y', NULL, '3');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/12892', 'photovoltaic_border_price', '2', '光伏边框', 'Y', 'Y', NULL, '4');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/13775', 'photovoltaic_film_price', '2', '光伏胶膜', 'Y', 'Y', NULL, '5');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/12896', 'photovoltaic_glass_price', '2', '光伏玻璃', 'Y', 'Y', NULL, '6');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/12632', 'poly_silicon_price', '2', '多晶硅', 'Y', 'Y', NULL, '7');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/12634', 'silicon_chip_price', '2', '硅片', 'Y', 'Y', NULL, '8');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/photovoltaic/list/12654', 'silver_paste_price', '2', '银浆', 'Y', 'Y', NULL, '9');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/silicon/list/11200', 'silicon_price', '2', '硅粉', 'Y', 'Y', NULL, '10');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/silicon/list/11196', 'dmc_price', '2', 'DMC', 'Y', 'Y', NULL, '11');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('上海有色金属', 'https://hq.smm.cn/silicon/list/11174', 'smm_price', '2', 'SMM', 'Y', 'Y', NULL, '12');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('东方财富网', 'https://so.eastmoney.com/quotation/s?keyword=%E6%B2%AA%E9%93%9C', 'copper_price', '2', 'Copper', 'Y', NULL, NULL, '13');
INSERT INTO spiderflow.spider_fetch_data_conf
(data_source_name, page_url, sink_table_name, get_page_count, `type`, isenable, is_grab_latest, ip_proxy, site_num)
VALUES('长江有色金属网', 'https://www.ccmn.cn/', 'photovoltaic_border_price', '2', '边框', 'Y', NULL, NULL, '14');
