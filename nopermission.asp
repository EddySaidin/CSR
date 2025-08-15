<div id="permwrap">
  <div class="error-perm">
    <div class="error-perm-page">
      <div>
        <h1>404</h1>
        <h2>oops! page not found</h2>
      </div>
      <a href="?action=home" title="Back to site" class="error-back">back</a> </div>
  </div>
</div>
<style>
   #permwrap {
   font: bold 16px/20px "Trajan Pro", "Times New Roman", Times, serif;
   color: #74A599;
   text-shadow: 0 1px 0 rgba(255, 255, 255, 0.15); 
   width:800px;
   margin-left:auto;
   margin-right:auto;
   overflow:hidden;
   }
   .error-perm {
   width: 600px;
   height: 310px;
   margin: 0 auto; 
   }
   .error-perm:before {
   box-shadow: 0 0 200px 150px #fff;
   width: 600px;
   height: 310px;
   border-radius: 5;
   position: relative;
   z-index: -1;
   content: '';
   display: block; 
   }
   .error-perm-page {
   width: 600px;
   height: 310px;
   border-radius: 5;
   top: -310px;
   position: relative;
   text-align: center;
   background: none; 
   }
   .error-perm-page:before {
   width: 63px;
   height: 63px;
   border-radius: 5;
   box-shadow: 3px 25px 0 5px #C95439;
   content: '';
   z-index: -1;
   display: block;
   position: relative;
   top: -19px;
   left: 44px; 
   }
   .error-perm-page:after {
   width: 600px;
   height: 17px;
   margin: 0 auto;
   top: 25px;
   content: '';
   z-index: -1;
   display: block;
   position: relative; 
   }
   .error-perm-page h1 {
   color: #fff;
   font-size: 150px;
   margin: 65px auto 0 auto;
   text-shadow: 0px 0 7px rgba(0, 0, 0, 0.5); 
   }
   .error-perm-page h1:before {
   width: 260px;
   height: 1px;
   position: relative;
   margin: 0 auto;
   top: 70px;
   content: '';
   display: block;
   }
   .error-perm-page h2 {
   margin: 75px 0 30px 0;
   font-size: 20px; 
   }
   .error-back {
   text-decoration: none;
   color: #74A599;
   font-size: 30px; 
   }
   .error-back:hover {
   color: #000;
   }
</style>
