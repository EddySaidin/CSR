<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="clsUpload.asp"-->
<%

private function FormatDate(input)
FormatDate = Year(CDate(input)) & "-" & Month(CDate(input)) & "-" & Day(CDate(input))
end function  
%>
<script>
function myFunction()
{
alert("I am an alert box!");
}
</script>
 
 /* remove space javascript */
	function removeSpaces(string) {
 		return string.split(' ').join('');
	}
</script>

<%

set o = new clsUpload
if o.Exists("button") then
	
	'kalau upload empty
	if o.FileNameOf("txtFile") = "" then
	else
	'get client file name without path
		sFileSplit = split(o.FileNameOf("txtFile"), "\")
		sFile = sFileSplit(Ubound(sFileSplit))

		o.FileInputName = "txtFile"
		o.FileFullPath = Server.MapPath(".") & "\upload\" & sFile
		o.save

		if o.Error = "" then
			response.write "Success. File saved to  " & o.FileFullPath & ". Demo Input = " & o.ValueOf("Demo")	
  		else
			response.write "Failed due to the following error: " & o.Error
 		end if
	 end if 
end if
set o = nothing
%>

<FORM ENCTYPE="multipart/form-data" METHOD="POST">
 
<table width="842" cellpadding="0" cellspacing="0" class="list_table" >
   <tr>
    	<td>File Attachment</td>
        <td>:</td>
        <td style="padding-left:0;"><input type="text" name="Demo" placeholder="not more than 200kb" /> **<input type="file" name="txtFile" ></td>
    </tr>
     <tr>
    	<td width="137"></td>
    	<td width="17"><input name="tpotensi" id="tpotensi" type="checkbox"  /></td>
    	<td width="686" colspan="4">Tanah Berpotensi (Jika Ya)</td>
  	</tr>
    <tr>
    	<td>&nbsp;</td>
    	<td><input name="toDo" type="hidden" value="add"></td>
    	<td><input type="submit" name="button" id="button" value="Save" >
      		<input type="reset" name="reset" id="button" value="Reset" />
        </td>
  	</tr>
    <tr><td colspan="4"><span style="color:white;">space</span></td></tr>
<!-- td colspan="3"><INPUT TYPE = "SUBMIT" NAME="button" VALUE="SUBMIT"></td-->
</table>
</FORM>



