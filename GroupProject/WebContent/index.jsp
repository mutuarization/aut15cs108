<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="include.jsp"/>
<title>Cardinal Quiz</title>
</head>
<body>
	<jsp:include page="header.jsp"/>
    <main>
    <div>
    	<div id="main-browse-container">
  <div id="browse-container">
  
    <div id="browse-results-container">
    <div class="result-selected-class">Latest Quizzes</div>	
      <input id="search-box" placeholder="Search by keywords or class code" class="">
      <ul id="browse-results-list">
      
      <% 
      %>
      
        <li class="browse-result ng-scope">
          <div class="title">Math 51 Midterm 1 Quiz</div>
          <div ng-show="class.description" class="description ng-binding">Created by Pat. Taken 25 times</div>
        </li><!-- end ngRepeat: class in classes | filter:query | orderBy:'code' --><li class="browse-result ng-scope" ng-repeat="class in classes | filter:query | orderBy:'code'" ng-click="toggleResult($event)">
          <div class="title ng-binding">Physics 43 Final Quiz</div>
          <div ng-show="class.description" class="description ng-binding">Created by Pat. Taken 37 times</div>
        </li><!-- end ngRepeat: class in classes | filter:query | orderBy:'code' --><li class="browse-result ng-scope" ng-repeat="class in classes | filter:query | orderBy:'code'" ng-click="toggleResult($event)">
          <div class="title ng-binding">CS103 Midterm Quiz</div>
          <div ng-show="class.description" class="description ng-binding">Created by Pat. Taken 88 times</div>
        </li><!-- end ngRepeat: class in classes | filter:query | orderBy:'code' --><li class="browse-result ng-scope" ng-repeat="class in classes | filter:query | orderBy:'code'" ng-click="toggleResult($event)">
          <div class="title ng-binding">CS107 Final Quiz</div>
          <div ng-show="class.description" class="description ng-binding">Created by Pat. Taken 22 times</div>
        </li>
        <%
        %>
      </ul>
    </div>
  </div>
  <div id="result-info-container">
    <div class="result-selected-class">Announcements</div>
    <div>
      <div class="result-relation-title">ClassQuiz is Now Live! (12/4)</div>
      <div class="prereqs">
        <ul>
          <div class="placeholder-text">
            After weeks of hard work, CardinalQuiz is now live. We hope everyone enjoys it!  
          </div>
        </ul>
      </div>

      <div class="result-relation-title">Updated Site Rules (11/23)</div>
      <div class="leads-to-classes">
        <ul>
          <div class="placeholder-text">
            Please don't post any NSFW quiz on CardinalQuiz!
          </div>
        </ul>
      </div>
    </div>
    
    <div class="ng-hide" style="padding-top: 40px;">
    <div class="result-selected-class">Previous Quizzes</div>	
      <div class="placeholder-container">
      	You haven't done any quiz. Perhaps you want to change that?
      </div>
    </div>
    <div class="add-class-container">
      <button ng-click="addClassToTree()">Take a Random Quiz</button>
    </div>
    
    <div class="ng-hide" style="padding-top: 40px;">
    <div class="result-selected-class">Achievements</div>	
      <div class="placeholder-container">
      	You don't have any achievements
      </div>
    </div> 
    
  </div>
  
</div>
    </div>
    </main>
</body>
</html>