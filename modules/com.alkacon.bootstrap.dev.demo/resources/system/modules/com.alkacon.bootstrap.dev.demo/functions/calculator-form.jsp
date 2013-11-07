<%@page buffer="none" session="false" taglibs="c,cms" %>

<div class="box box_schema1">

	<%-- Title of the article --%>
	<h4>Simple calculator</h4>
	<div class="boxbody">
		<%-- The text field of the article with image --%>		
		<div class="paragraph">
			<form action="${cms.functionDetail['simplecalculator']}" method="post">
				<input type="text" size="8" maxlength="6" name="operant1" />
				<select name="operator">
					<option>+</option>
					<option>-</option>
					<option>*</option>
					<option>/</option>															
				</select>
				<input type="text" size="8" maxlength="6" name="operant2" />
				<p>&nbsp;</p>
				<input type="submit" value="Calculate" />
			</form>	
		</div>		
	</div>
</div>