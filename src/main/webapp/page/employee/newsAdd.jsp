<%--
  Created by IntelliJ IDEA.
  User: adds
  Date: 2018/7/24
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>文章列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="../../layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="../../css/public.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form layui-row layui-col-space10">
    <input type="hidden" id="myPathValue" value="${pageContext.request.contextPath}" />
    <div class="layui-col-md9 layui-col-xs12">
        <div class="layui-row layui-col-space10">
            <div class="layui-col-md9 layui-col-xs7">
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">文章标题</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input newsName" lay-verify="newsName" placeholder="请输入文章标题">
                        <input type="text" class="layui-input IsEdit layui-hide"  placeholder="这里用来区分是编辑还是新增">
                        <input type="text" class="layui-input articleId layui-hide"  placeholder="articleId">
                    </div>
                </div>
                <%--<div class="layui-form-item">--%>
                    <%--<label class="layui-form-label">内容摘要</label>--%>
                    <%--<div class="layui-input-block">--%>
                        <%--<textarea placeholder="请输入内容摘要" class="layui-textarea abstract"></textarea>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>
            <%--<div class="layui-col-md3 layui-col-xs5">--%>
                <%--<div class="layui-upload-list thumbBox mag0 magt3">--%>
                    <%--<img class="layui-upload-img thumbImg">--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
        <div class="layui-form-item magb0">
            <label class="layui-form-label">附件</label>
            <div class="layui-input-block">
                <div class="layui-upload">
                    <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
                    <div class="layui-upload-list">
                        <table class="layui-table">
                            <thead>
                            <tr><th>文件名</th>
                                <th>大小</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr></thead>
                            <tbody id="demoList"></tbody>
                        </table>
                    </div>
                    <button type="button" class="layui-btn" id="testListAction">开始上传</button>
                </div>
            </div>
        </div>
        <div class="layui-form-item magb0">
            <label class="layui-form-label">文章内容</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea layui-hide content" name="content" lay-verify="content" id="news_content"></textarea>
            </div>
        </div>
    </div>
    <div class="layui-col-md3 layui-col-xs12">
        <%--<blockquote class="layui-elem-quote title"><i class="seraph icon-caidan"></i> 分类目录</blockquote>--%>
        <%--<div class="border category">--%>
            <%--<div class="">--%>
                <%--<p><input type="checkbox" name="news" title="新闻" lay-skin="primary" /></p>--%>
                <%--<p><input type="checkbox" name="goods" title="商品" lay-skin="primary" /></p>--%>
                <%--<p><input type="checkbox" name="notice" title="公告" lay-skin="primary" /></p>--%>
                <%--<p><input type="checkbox" name="images" title="图片" lay-skin="primary" /></p>--%>
            <%--</div>--%>
        <%--</div>--%>
        <blockquote class="layui-elem-quote title magt10"><i class="layui-icon">&#xe609;</i> 发布</blockquote>
        <div class="border">
            <%--<div class="layui-form-item">--%>
                <%--<label class="layui-form-label"><i class="layui-icon">&#xe60e;</i> 状　态</label>--%>
                <%--<div class="layui-input-block newsStatus">--%>
                    <%--<select name="status" lay-verify="required">--%>
                        <%--<option value="0">保存草稿</option>--%>
                        <%--<option value="1">等待审核</option>--%>
                    <%--</select>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="layui-form-item">--%>
                <%--<label class="layui-form-label"><i class="layui-icon">&#xe609;</i> 发　布</label>--%>
                <%--<div class="layui-input-block">--%>
                    <%--<input type="radio" name="release" title="立即发布" lay-skin="primary" lay-filter="release" checked />--%>
                    <%--<input type="radio" name="release" title="定时发布" lay-skin="primary" lay-filter="release" />--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="layui-form-item layui-hide releaseDate">--%>
                <%--<label class="layui-form-label"></label>--%>
                <%--<div class="layui-input-block">--%>
                    <%--<input type="text" class="layui-input" id="release" placeholder="请选择日期和时间" readonly />--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="layui-form-item department">
                <label class="layui-form-label"><i class="seraph icon-look"></i>部门</label>
                <div class="layui-input-block">
                    <input type="radio" name="department"  value="accap" title="财务部" lay-skin="primary" />
                    <input type="radio" name="department" value="purchase" title="采购部" lay-skin="primary" />
                </div>
            </div>
            <div class="layui-form-item openness">
                <label class="layui-form-label"><i class="seraph icon-look"></i>邮件</label>
                <div class="layui-input-block">
                    <input type="radio" name="openness"  value="1" title="发送" lay-skin="primary" checked />
                    <input type="radio" name="openness" value="0" title="不发送" lay-skin="primary" />
                </div>
            </div>
            <div class="layui-form-item newsTop">
                <label class="layui-form-label"><i class="seraph icon-zhiding"></i>隐藏</label>
                <div class="layui-input-block">
                    <input type="checkbox" name="newsTop" lay-skin="switch" lay-text="是|否">
                </div>
            </div>
            <hr class="layui-bg-gray" />
            <div class="layui-right">
                <a class="layui-btn layui-btn-sm" lay-filter="addNews" lay-submit><i class="layui-icon">&#xe609;</i>发布</a>
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-filter="look" lay-submit>保存</a>
            </div>
        </div>
    </div>
</form>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script type="text/javascript" src="newsAdd.js"></script>
</body>
</html>
