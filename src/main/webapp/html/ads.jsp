 <%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;utf-8"%>

      <script type="text/javascript">

             /*
            * 查所有
            * */
         function init(){
              $("#myBody").empty();
              $.ajax({
                  url: "${pageContext.request.contextPath}/uc/examineController",
                  datatype: "json",
                  success: function (data) {
                      /*
                      * index：遍历的下标
                      * item： 每一条数据
                      * */
                      $.each(data, function (index, item) {
                          $("#myBody").append("<tr>" +
                              "<td>" + item.id + "</td>" +
                              "<td>" + item.name + "</td>" +
                              "<td>" + item.password + "</td>" +
                              "<td>" + item.birthday + "</td>" +
                              "<td>" + item.phone + "</td>" +
                              "<td>" + item.state + "</td>" +
                              "<td> <button id='"+item.id+"' class='btn btn-primary' onclick='updateUser(this)'>修改</button>" +
                              "<button id='"+item.id+"' onclick='deleteUser(this)' class='btn btn-primary'>删除</button></td>" +
                              "</tr>")
                      })
                  }
              })
          }
          $(function () {
              /*
              * 展示字段
              * */
            $("#selectByLike").click(function(){
                  $("#myBody").empty();
                    var val = $("#username1").val();
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/gaoliang",
                    datatype:"json",
                    data:{"ming":val},
                    success:function(data){
                        $.each(data, function (index, item) {
                            $("#myBody").append("<tr>" +
                                "<td>" + item.id + "</td>" +
                                "<td>" + item.name + "</td>" +
                                "<td>" + item.password + "</td>" +
                                "<td>" + item.birthday + "</td>" +
                                "<td>" + item.phone + "</td>" +
                                "<td>" + item.state + "</td>" +
                                "</tr>")
                        })
                    }
                })
            })


              /*改表
              *表              表           表
              * */
              $("#list").jqGrid({
                  url:"${pageContext.request.contextPath}/user/selectController",
                editurl:"${pageContext.request.contextPath}/user/addupdatedelete",
                  /*
                  * addupdatedleete
                  * */
                  datatype:"json",
                  autowidth:true,
                  viewrecords:true,
                    cellEdit:true,
                     rowNum:2,
                     pager:"#pager",
                    colNames:[
                        "id","name","password","birthday","phone","state"
                    ],
                  colModel:[
                      {name:"id"},
                      {name:"name",editable:true},
                      {name:"password",editable:true},
                      {name:"birthday",editable:true},
                      {name:"phone",editable:true},
                      {name:"state",editable:true,edittype:"select",editoptions:{
                              value:"激活:激活;未激活:未激活"
                          }}


                  ],
              }).jqGrid("navGrid","#pager",{
                  //可以禁用某些功能，如：添加
              },{reloadAfterSubmit:false,closeAfterEdit:true},{closeAfterAdd:true},{closeAfterDel:true});
              /*
              * 获取用户信息
              * */
              init();
             /*
             * 添加用户
             * */
              $("#mySave").click(function () {
                   var serialize = $("#addUser").serialize();
                   $.ajax({
                       url:"${pageContext.request.contextPath}/uc/addController",
                       datatype:"json",
                       data:serialize,
                       success:function(){
                        $("#myModal").modal("hide");
                        $("#addUser")[0].reset();
                           init();
                       }
                   })
              })
              /*
              * 模糊查
              * */
              $("#selectByLike").click(function(){
                  console.log($("#slectByLikeForm").serialize());
                  $.ajax({
                      url:"${pageContext.request.contextPath}/uc/mhuController",
                      datatype:"json",
                      data:$("#slectByLikeForm").serialize(),

                      success:function(data){
                          console.log(data);
                          $("#myBody").empty();
                          $.each(data, function (index, item) {
                              $("#myBody").append("<tr>" +
                                  "<td>" + item.id + "</td>" +
                                  "<td>" + item.name + "</td>" +
                                  "<td>" + item.password + "</td>" +
                                  "<td>" + item.birthday + "</td>" +
                                  "<td>" + item.phone + "</td>" +
                                  "<td>" + item.state + "</td>" +
                                  "<td> <button id='"+item.id+"' class='btn btn-primary' onclick='updateUser(this)'>修改</button><button class='btn btn-primary'>删除</button></td>" +
                                  "</tr>")
                          })
                      }
                  })
              })
              /*
              *  修改
              * */
              $("#updateButton").click(function(){
                  var serialize = $("#updateForm").serialize();
                    $.ajax({
                        url:"${pageContext.request.contextPath}/uc/amendController",
                         data:serialize,
                        datatype:"json",
                        success:function(){
                            $("#myModa12").modal("hide");
                            $("#updateForm")[0].reset();
                                init();
                  }
              })
              })
          })
          /*
              *  修改回显
              * */
          function updateUser(item){
              var id = $(item).attr("id");
              $.ajax({
                  url:"${pageContext.request.contextPath}/uc/chaController",
                  datatype:"json",
                  data:{"id":id},
                  success:function(data){
                      $("#inputId").val(data.id)
                      $("#inputName").val(data.name)
                      $("#inputPassword").val(data.password)
                      $("#inputBirthday").val(data.birthday)
                      $("#inputPhone").val(data.phone)
                      var status = data.state;
                      if (status=="激活"){
                          $("#status2").val('激活')
                      }else{
                          $("#status2").val('未激活')
                      }
                      /*
                      * 模态框
                      * */
                      $("#myModa12").modal("show")
                  }
              })
          }
          /*
          * 删除
          * */
          function deleteUser(item){
              var id = $(item).attr("id");
              $.ajax({
                  url:"${pageContext.request.contextPath}/uc/removeController",
                  data:{"id":id},
                  datatype:"json",
                  success:function(){
                      init();
                  }
              })
          }
      </script>

<div class="col-sm-10" style="margin-top: -35px">
    <div class="page-header">
        <h3 id="myH3">用户管理</h3>
    </div>
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#showUser" data-toggle="tab">用户列表</a>
        </li>
        <li>
            <a href="#" data-toggle="modal" data-target="#myModal">用户添加</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="showUser">
            <div class="panel panel-default">
                <%--
                    heading搜索
                --%>
                <div class="panel-heading text-center">
                    <form id="slectByLikeForm" class="form-inline">
                        <div class="form-group">
                            <%--<label for="username1">姓名</label>--%>
                            <input type="text" name="ming" placeholder="请输入" class="form-control" id="username1">
                        </div>
                        <%--<div class="form-group">
                            <label for="phoneNumber1">手机号</label>
                            <input type="text" name="phone" placeholder="输入手机号" class="form-control" id="phoneNumber1">
                        </div>
                        <div class="form-group">
                            <label>激活状态</label>
                            <select class="form-control" name="state">
                                <option value="0">--请选着--</option>
                                <option value="激活">激活</option>
                                <option value="未激活">未激活</option>
                            </select>
                        </div>--%>
                        <button type="button" data-toggle="modal" data-target="#myModa13" id="selectByLike"  class="btn btn-primary">
                           <%-- <button type="button" data-toggle="modal" data-target="#myModal">Launch modal</button>--%>
                            查询
                        </button>
                    </form>
                </div>
                <%--
                    body
                --%>
                <div class="panel-body">
                    <%--
                        表格数据
                    --%>
                    <table id="list" class="table table-striped table-bordered table-hover">
                       <%-- <thead>
                        <tr>
                            <th>Id</th>
                            <th>姓名</th>
                            <th>密码</th>
                            <th>生日</th>
                            <th>手机号</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>--%>
                       <%-- <tbody id="myBody">

                        </tbody>--%>
                    </table>

                    <%--
                        分页
                    --%>
                    <div id="pager"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--添加模态框-->
<div class="modal fade" tabindex="-1" id="myModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  添加用户
            </div>
            <div class="modal-body">
                <form id="addUser" method="post"  class="form-horizontal">
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2 control-label">Name</label>
                    <div class="col-sm-10">
                        <input type="text" name="name" class="form-control" id="inputEmail3" placeholder="Name">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword1" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                        <input type="password" name="password" class="form-control" id="inputPassword1" placeholder="Password">
                    </div>
                </div>
                    <div class="form-group">
                        <label for="inputBirthdays" class="col-sm-2 control-label">Birthday</label>
                        <div class="col-sm-10">
                            <input type="date" name="birthday" class="form-control" id="inputBirthdays" placeholder="Birthday">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPhones" class="col-sm-2 control-label">Phone</label>
                        <div class="col-sm-10">
                            <input type="text" name="phone" class="form-control" id="inputPhones" placeholder="Phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">激活状态</label>
                          <div class="col-sm-3">
                        <select name="state" class="form-control">
                            <option  selected="selected">---请选择---</option>
                            <option value="未激活">---未激活---</option>
                            <option value="激活">----激活----</option>
                        </select>
                          </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" id="mySave" class="btn btn-primary">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!--修改模态框-->
<div class="modal fade" tabindex="-1" id="myModa12">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                修改用户
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updateForm">
                    <input type="hidden" name="id" value="id" id="inputId">
                    <div class="form-group">
                        <label for="inputName" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="inputName" placeholder="Name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-2 control-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" name="password" class="form-control" id="inputPassword" placeholder="Password">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputBirthday" class="col-sm-2 control-label">Birthday</label>
                        <div class="col-sm-10">
                            <input type="date" name="birthday" class="form-control" id="inputBirthday" placeholder="Birthday">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPhone" class="col-sm-2 control-label">Phone</label>
                        <div class="col-sm-10">
                            <input type="text" name="phone" class="form-control" id="inputPhone" placeholder="Phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="status2" class="col-sm-2 control-label">激活状态</label>
                        <div class="col-sm-3">
                            <select name="state" id="status2" class="form-control">
                                <option value="未激活">---未激活---</option>
                                <option value="激活">----激活----</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="updateButton">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>


 <%--高亮字段--%>
 <div class="modal fade" tabindex="-1" id="myModa13">
     <div class="modal-dialog" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                 展示相关信息
             </div>
                    <h1>${requestScope.mms}</h1>
             <div class="modal-body">
                 <table id="listsss" class="table table-striped table-bordered table-hover">
                      <thead>
                      <tr>
                          <th>Id</th>
                          <th>姓名</th>
                          <th>密码</th>
                          <th>生日</th>
                          <th>手机号</th>
                          <th>状态</th>
                      </tr>
                      </thead>
                     <tbody id="myBody">
                      </tbody>
                 </table>
         </div>
         </div>
     </div>
 </div>