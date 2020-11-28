<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	</div>

	<div id="footer">
		<div class="row">
			<div class="col-md-12" style="width: 100%; text-align: center; padding: 3%;">
				4. Copyright
			</div>
		</div>
	</div>
	
</div>
</body>

<script type="text/javascript">
    function func_height() {
      var content_height = $("div#content").height(); 
      // header.jsp 의 하단에 표시된 div content 의 height 값
      
      $("div#sideinfo").height(content_height);
      // header.jsp 의 div sideinfo 의 height 값으로 설정하기 
    }
</script>

</html>    
    