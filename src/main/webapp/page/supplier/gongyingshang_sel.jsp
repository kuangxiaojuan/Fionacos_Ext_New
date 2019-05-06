﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="com.colin.entity.User" %>
<%@ page import="com.colin.tool.ParseJsonParam" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%@ page import="com.colin.entity.Params" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) request.getSession().getAttribute("user");
	String un  = user.getUsername();
	if(un==null){
		String url  = basePath+"/user/logout";
		response.sendRedirect(url);
		return;
	}

	String datestart=request.getParameter("datestart");
	String datestop=request.getParameter("datestop");
	String area=request.getParameter("area");//new String(request.getParameter("area").getBytes("ISO-8859-1"),"UTF-8" );
	String mcdc=request.getParameter("mcdc");//new String(request.getParameter("mcdc").getBytes("ISO-8859-1"),"UTF-8" );
	String brand=request.getParameter("brand");//new String(request.getParameter("brand").getBytes("ISO-8859-1"),"UTF-8" );
	String imdsc1=request.getParameter("imdsc1");//new String(request.getParameter("imdsc1").getBytes("ISO-8859-1"),"UTF-8" );
	String statu=request.getParameter("statu");//new String(request.getParameter("statu").getBytes("ISO-8859-1"),"UTF-8" );
	String limcu=request.getParameter("limcu");//new String(request.getParameter("limcu").getBytes("ISO-8859-1"),"UTF-8" );

	Calendar   cal   =   Calendar.getInstance();
	cal.add(Calendar.DATE,   -30);

	if(datestart==""){
		datestart = new SimpleDateFormat("yyyy-MM-dd ").format(cal.getTime());
	}

	if(datestop==""){
		datestop = new SimpleDateFormat("yyyy-MM-dd ").format(new Date());
	}
//area =URLDecoder.decode(area,"utf-8");


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">

	<title>供应商条码查询</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src='${pageContext.request.contextPath}/js/jquery-2.1.1.min.js'></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>riliJs/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/jquery.fileDownload.js"></script>
	<style type="text/css">
		body{
			background: white;
			margin: 0 auto;
			overflow: hidden;
		}
		.head{
			width: 100%;
			height: 68px;
			background: #2A343E;
			color: white;
			font-size:1.15em;
			line-height: 30px;
			font-weight: bold;
			padding: 2px;
			border: 1px solid gray;
			box-sizing: border-box;
		}
		#main{
			width: 100%;
			height: 83%;
			overflow: auto;
		}

		table {
			text-align: center;
			width: 100%;
			border-width: 0px 1px 1px 0px;
			border: 1px solid gray;
			box-sizing: border-box;
			font-size: 10px;
		}
		td {
			border-width: 0px 1px 1px 0px;
			border: 1px solid gray;
			box-sizing: border-box;
		}
		tr:hover{
			color: #2365ff;
			cursor: pointer;
		}
		#hide_div{
			width: 100%;height: 98%;z-index: 99;position:absolute;filter: alpha(opacity=10);opacity: 0.5; background: white;
			cursor: pointer;
		}
		#loading_div{
			margin-left: 38%;
			margin-top: 15%;
		}
	</style>
	<script type="text/javascript">
    var un  ="<%=un%>";
    var layer = parent.layer === undefined ? layui.layer : top.layer;
    var index = layer.msg('加载中，请稍候',{icon: 16,time:false,shade:0.8});
    function showsel(){
        var datestart,datestop;
        datestart =$("#datestart").val();
        datestop =$("#datestop").val();
        area = $("#area").val();
        mcdc = $("#mcdc").val();
        brand = $("#brand").val();
        imdsc1 = $("#imdsc1").val();
        limcu = $("#limcu").val();

        // area=encodeURI(area);
        // area=encodeURI(area);

        if(datestart==""||datestop==""){
            showconfirm("请选择日期!","","");
            return;
        }
        window.location.href="page/supplier/gongyingshang_sel.jsp?datestart="+datestart+"&datestop="+datestop+"&area="+area+"&mcdc="+mcdc+"&limcu="+limcu+"&brand="+brand+"&imdsc1="+imdsc1+"&statu=2";
        index = layer.msg('加载中，请稍候',{icon: 16,time:false,shade:0.8});
    }


    /*
    *  导出
    */
    function exportReport(){
        var datestart,datestop;
        datestart =$("#datestart").val();
        datestop =$("#datestop").val();
        area = $("#area").val();
        mcdc = $("#mcdc").val();
        brand = $("#brand").val();
        imdsc1 = $("#imdsc1").val();
        limcu = $("#limcu").val();

        if(datestart==""||datestop==""){
            showconfirm("请选择日期!","","");
            return;
        }
        //转码
        area=encodeURI(area);
        area=encodeURI(area);

        mcdc=encodeURI(mcdc);
        mcdc=encodeURI(mcdc);

        brand=encodeURI(brand);
        brand=encodeURI(brand);

        imdsc1=encodeURI(imdsc1);
        imdsc1=encodeURI(imdsc1);

        limcu=encodeURI(limcu);
        limcu=encodeURI(limcu);

        var url="<%=basePath%>export/exportGongYingShangSel?datestart="+datestart+"&datestop="+datestop
            +"&gongyingshang="+un+"&area="+area+"&mcdc="+mcdc+"&limcu="+limcu+"&brand="+brand+"&imdsc1="+imdsc1;
        loadDown(url);
        // var link= $('<a href="'+url+'" download="'+ datestart +'至'+datestop +'区域销售/库存报表.xls'+'"></a>');
        // link.get(0).click();
        // link.remove();
    }

    //文件下载
    function loadDown(url){
        $.fileDownload(url,{
            prepareCallback:function(url){
                index = layer.msg('文件导出中，请稍候',{icon: 16,time:false,shade:0.8});
            },
            successCallback: function(url){
                layer.close(index);
            },
            failCallback: function (html, url) {
                layer.close(index);
            }
        });
    }

    //判断页面是否加载完成
    document.onreadystatechange = loadingChange;//当页面加载状态改变的时候执行这个方法.
    function loadingChange()
    {
        if(document.readyState == "complete"){ //当页面加载状态为完全结束时进入
            //当页面加载完成后将loading页隐藏
            layer.close(index);
        }
    }
	</script>

</head>

<body>
<div id="hide_div">
	<div id="loading_div">
		<img style="width: 40px;height: 40px" src="images/loading.gif"></img>
	</div>
</div>
<div class="head">供应商条码查询（<b id="tishi"></b>）
	<div>
		<input type="text" id="datestart" placeholder="起始日期" class=Wdate   onClick=WdatePicker() value="<%=datestart %>" >
		~<input type="text" id="datestop" placeholder="结束日期" class=Wdate   onClick=WdatePicker() value="<%=datestop %>">
		<input type="text" id="area" placeholder="区域"  value="<%=area %>">
		<input type="text" id="mcdc" placeholder="门店" value="<%=mcdc %>">
		<input type="text" id="limcu" placeholder="门店编号" value="<%=limcu %>">
		<input type="text" id="brand" placeholder="品牌" value="<%=brand %>">
		<input type="text" id="imdsc1" placeholder="商品说明" value="<%=imdsc1 %>">
		<button onclick="showsel()">查询</button>
		<button onclick="exportReport()">导出</button>
	</div>
</div>
<div id="main">
	<div id="data_tab">

		<%
			if(!statu.equals("1")){
				ParseJsonParam pjp = new ParseJsonParam();
				area =URLEncoder.encode(area,"utf-8");
				mcdc =URLEncoder.encode(mcdc,"utf-8");
				brand =URLEncoder.encode(brand,"utf-8");
				imdsc1 =URLEncoder.encode(imdsc1,"utf-8");
				limcu =URLEncoder.encode(limcu,"utf-8");
				//183.11.241.154:8081	192.168.15.252:818
				String url = "http://183.11.241.154:8081/Ext_interface/ext/gongyingshang/getext_json_sel.jsp?datestart="+
						datestart.trim()+"&datestop="+datestop.trim()+"&gongyingshang="+
						un+"&area="+area+"&mcdc="+mcdc+"&limcu="+limcu+"&brand="+brand+"&imdsc1="+imdsc1;
				System.out.println(url+">>>");
				String json = pjp.loadJSON(url);
				List<Params> list=JSON.parseArray(json,Params.class);
				int kucunqty=0;
				int sqleqty=0;
				double amount=0.0;
				String tablestr ="";
				int countst =0;
				tablestr ="<table>"+
						"<tr>"+
						"<td>门店/仓库编码</td>"+
						"<td>门店/仓库</td>"+
						"<td>供应商编码</td>"+
						"<td>供应商名称</td>"+
						"<td>国际条码</td>"+
						"<td>条码说明</td>"+
						"<td>库存数量</td>"+
						"<td>品牌</td>"+
						"<td>区域</td>"+
						"<td>周期销售数量</td>"+
						"<td>周期销售金额</td>"+
						"</tr>";


				//System.out.println(list.size()+">>>");
				for (Params params : list) {
					tablestr+="<tr>";
					tablestr+="<td>"+params.getParam1()+"</td>";
					tablestr+="<td>"+params.getParam2()+"</td>";
					tablestr+="<td>"+params.getParam3()+"</td>";
					tablestr+="<td>"+params.getParam4()+"</td>";
					tablestr+="<td>"+params.getParam5()+"</td>";
					tablestr+="<td>"+params.getParam6()+"</td>";
					tablestr+="<td>"+params.getParam9()+"</td>";
					tablestr+="<td>"+params.getParam7()+"</td>";
					tablestr+="<td>"+params.getParam8()+"</td>";
					tablestr+="<td>"+params.getParam10()+"</td>";
					tablestr+="<td>"+params.getParam11()+"</td>";
					tablestr+="</tr>";
					countst++;
													               /*
													               kucunqty+=Integer.parseInt(params.getParam7()); 
													               sqleqty+=Integer.parseInt(params.getParam10());*/
					if(countst==500){
						tablestr+="<tr ><font color=red>数量大于500,详情请导出查看!</font></tr>";
						break;
					}
					//System.out.println(params.getParam7()+">>>"+params.getParam10()+">>>"+countst);
				}

				countst =0;
				kucunqty=0;
				sqleqty=0;
				amount=0;
				for (Params params : list) {
					kucunqty+=Integer.parseInt(params.getParam9());
					sqleqty+=Integer.parseInt(params.getParam10());
					amount+=Double.parseDouble(params.getParam11());

					countst++;
				}

				tablestr+="<tr><td colspan=9>当前行数:<font color=#0000ff>"+countst+"</font>"+
						"库存数量:<font color=#0000ff>"+kucunqty+"</font>"+
						"销售数量:<font color=#0000ff>"+sqleqty+"</font>"+
						"销售金额:<font color=#0000ff>"+amount+"</font>"+
						"</td></tr>";
				tablestr +="</table>";

				out.write(tablestr);
				/**/
				out.write("<script type=\"text/javascript\">  $(\"#tishi\").html(\"当前行数:<font color=#8ADBC0>"+countst+"</font>库存数量:<font color=#8ADBC0>"+kucunqty+"</font>销售数量:<font color=#8ADBC0>"+sqleqty+"</font>销售金额:<font color=#8ADBC0>"+amount+"</font>\");</script>");
				out.write("<script type=\"text/javascript\">  $(\"#hide_div\").hide();</script>");
			}else{
                        /*
                        ParseJsonParam pjp = new ParseJsonParam();                                        
			                    area =URLEncoder.encode(area,"utf-8");
			                    mcdc =URLEncoder.encode(mcdc,"utf-8");
			                    brand =URLEncoder.encode(brand,"utf-8");
			                    imdsc1 =URLEncoder.encode(imdsc1,"utf-8");
			                    //183.11.241.154:8081	192.168.15.252:818
								String url = "http://183.11.241.154:8081/Ext_interface/ext/gongyingshang/getext_json_sel.jsp?datestart="+
								datestart.trim()+"&datestop="+datestop.trim()+"&gongyingshang="+
								un+"&area="+area+"&mcdc="+mcdc+"&brand="+brand+"&imdsc1="+imdsc1;
								//System.out.println(url+">>>");
						        String json = pjp.loadJSON(url);
			                        //System.out.println(json +">>>");
			
						        JSONArray jArray=JSONArray.fromObject(json);  
						        List<Params> list=JSONArray.toList(jArray,Params.class); 
						        int kucunqty=0;
						        int sqleqty=0;
						        String tablestr ="";
						        int countst =0;
						        */

				out.write("<p>&nbsp;默认不显示查询结果，请点击查询/导出按钮查看数据!</p>");
						        /*
						        countst =0;
						        kucunqty=0;
						        sqleqty=0;
						        for (Params params : list) {
						           kucunqty+=Integer.parseInt(params.getParam7()); 
								   sqleqty+=Integer.parseInt(params.getParam10());
								   countst++; 
						        }
						           
			                     out.write("<script type=\"text/javascript\">  $(\"#tishi\").html(\"当前行数:<font color=#8ADBC0>"+countst+"</font>库存数量:<font color=#8ADBC0>"+kucunqty+"</font>销售数量:<font color=#8ADBC0>"+sqleqty+"</font>\");</script>");
			                     */
				out.write("<script type=\"text/javascript\">  $(\"#hide_div\").hide();</script>");
			}
		%>
	</div>




</div>
</body>
</html>
