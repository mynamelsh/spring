
function $(idName){
	return document.getElementById(idName);
}
function delRow(tag){
	var tr=tag.parentNode.parentNode;
	var tbody=$("tbody");
	tbody.removeChild(tr);
}
function selectAll(){
	//1.获得网页所有的input标签
	var inps=document.getElementsByTagName("input");
	//2.获得数组里所有的类型为checkbox的标签
	for(var i=0;i<inps.length;i++){
		if(inps[i].type=="checkbox"){
			inps[i].checked="checked";
		}
	}
}
function quxiao(){
	var inps=document.getElementsByTagName("input");
	for(var i=0;i<inps.length;i++){
		if(inps[i].type=="checkbox"){
			inps[i].checked="";
		}
	}
}
function deleteSelected(){
	var inps=document.getElementsByTagName("input");
	for(var i=inps.length-1;i>=0;i--){
		if(inps[i].checked){
			delRow(inps[i]);
		}
	}
}
function over(tag){
	tag.style.color="white";
	tag.style.backgroundColor="pink";
}
function out(tag){
	tag.style.color="black";
	tag.style.backgroundColor="white";
}
function sub(tag){
	var numtxt=tag.nextSibling; //获得数量的文本框
	var price=tag.parentNode.previousSibling.innerHTML;//获得价格列
	var num=numtxt.value; //获得数量文本框内容
	if(num>1){
		num=num-0-1;
	}
	numtxt.value=num+"";
	var totalprice=price*num; //获得总价
	//获得总价文本框,设置总价
	tag.parentNode.nextSibling.innerHTML=totalprice;
}
function add(tag){
	var numtxt=tag.previousSibling; //获得数量的文本框
	//获得价格列,如果定义价格标签时回车换行了，
	//那么nextSibling得到的是文本节点，不是文本框
	var price=tag.parentNode.previousSibling.innerHTML;
	var num=numtxt.value; //获得数量文本框内容

	if(num<9){
		num=num-0+1;
	}
	numtxt.value=num+"";
	var totalprice=price*num; //获得总价

	//获得总价文本框,设置总价
	tag.parentNode.nextSibling.innerHTML=totalprice;
}
function init(){
	var inps=document.getElementsByTagName("input");
	for(var i=0;i<inps.length;i++){
		if(inps[i].type=="text"){
			if(inps[i].previousSibling.type=="button"){
				inps[i].value=1;
			}else{
				inps[i].value="";
			}
		}
	}
}