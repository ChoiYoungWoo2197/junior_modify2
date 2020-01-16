</html><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />

<link href="${pageContext.request.contextPath}/resources/css/common/read.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reservationDetail/read.js"></script>

<section class="width1200">
   <h1>예약 상세보기</h1>
   <img src="${pageContext.request.contextPath}/resources/images/list2.png" id="list" class="float_right icon_img">
      
   <form name="reservationDetailForm" id="reservationDetailForm" method="post" onsubmit="return false;">
      <table>
         <tr>
            <th>
               예약번호
            </th>
            <td>
               <span>${reservation.reservationId}</span>
            </td>
         </tr>
         <tr>
            <th>
               예약사용일시
            </th>
            <td >
               <span>
               <fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd" /> <fmt:formatDate value="${reservation.startDate}" pattern="kk:mm" /> ~ <fmt:formatDate value="${reservation.actualEndDate}" pattern="kk:mm" />
               <input type="hidden" size="50" name="startTime" value=<fmt:formatDate value="${reservation.startDate}" pattern="kk:mm" /> />
               <input type="hidden" size="50" name="actualEndDay" value=<fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd" /> />
               <input type="hidden" size="50" name="actualEndTime" value=<fmt:formatDate value="${reservation.actualEndDate}" pattern="kk:mm" /> />
               <c:if test="${not empty limitReservation}">
               <input type="hidden" size="50" name="limitReservation" value=<fmt:formatDate value="${limitReservation}" pattern="kk:mm" /> />
               </c:if>
               
               </span>
            </td>
         </tr>
         <tr>
            <th>
               회의실명
            </th>
            <td >
               <span>${reservation.meetingRoomName}</span>
            </td>
         </tr>
         <tr>
            <th>
               회의목적
            </th>
            <td >
               <span>${reservation.meetPurpose}</span>
            </td>
         </tr>
         <tr>
            <th>
               참석자수
            </th>
            <td >
               <span>${reservation.meetAttendess}명</span>
            </td>
         </tr>
         <tr>
            <th>
               상태
            </th>
            <td >
               <c:choose>
                  <c:when test="${reservation.state eq 'R'}">
                     <fmt:formatDate value="${now}" pattern="yyyy.MM.dd kk:mm" var="today" />
                     <fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd kk:mm" var="startDate" />
                     <fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" var="actualEndDate" />
                     <c:choose>
                        <c:when test="${today >= startDate  &&  today < actualEndDate}">
                           <span>진행중</span>
                        </c:when>
                        <c:otherwise>
                           <span>예약</span>
                        </c:otherwise>
                     </c:choose>
                  </c:when>
                  <c:when test="${reservation.state eq 'RC'}">
                     <span>예약취소</span>
                  </c:when>
                  <c:when test="${reservation.state eq 'E'}">
                     <span>연장</span>
                  </c:when>
                  <c:when test="${reservation.state eq 'F'}">
                     <span>종료</span>
                  </c:when>
                  <c:when test="${reservation.state eq 'FV'}">
                     <span>종료확인</span>
                  </c:when>
               </c:choose>
            </td>
         </tr>
         <tr>
            <th>
               신청자
            </th>
            <td >
               <span>${reservation.employeeName}</span>
            </td>
         </tr>
         <tr>
            <th>
               소속부서
            </th>
            <td >
               <span>${reservation.departmentName}</span>
            </td>
         </tr>
         <!-- 바꿔야됨.  -->
         <c:choose>
            <c:when test="${reservation.state eq 'R'}">
            <tr id="trLast" class="tr_last_child">
               <th >예약신청일시</th>
               <td><fmt:formatDate value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm" /></td>
            </tr>
            </c:when>
            
            <c:when test="${reservation.state eq 'RC'}">
            <tr >
               <th >예약신청일시</th>
               <td><fmt:formatDate value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm" /></td>
            </tr>
            <tr class="tr_last_child">
               <th>취소사유</th>
               <td ><span>${reservation.cancelReason}</span></td>
            </tr>
            </c:when>

            <c:when test="${reservation.state eq 'E' && not empty extend}">
            <tr >
               <th >예약신청일시</th>
               <td><fmt:formatDate value="${reservation.reservationDate}" pattern="yyyy.MM.dd kk:mm" /></td>
            </tr>
            <tr>
               <th>종료일시</th>
               <td ><fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" /></td>
            </tr>
            <tr class="tr_last_child"  id="extendTr">
               <th>연장사유</th>
               <td ><span>${extend.extendReason}</span></td>
            </tr>   
            </c:when>
            
            <c:when test="${reservation.state eq 'F' || reservation.state eq 'FV'}">
               <tr class="tr_last_child" id="finishTr">
                  <th>
                     종료일시
                  </th>
                  <td >
                     <fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" />
                  </td>
               </tr>
               <c:if test="${not empty extend}">
                  <tr>
                     <th>
                        연장사유
                     </th>
                     <td >
                        <span>${extend.extendReason}</span>
                     </td>
                  </tr>
               </c:if>
               <c:if test="${reservation.state eq 'FV'}">
                  <tr class="tr_last_child">
                     <th>
                        이상유무
                     </th>
                     <td >
                        <span>${reservation.abnormality}</span>
                     </td>
                  </tr>
               </c:if>
            </c:when>
         </c:choose>
         
         <tr id="inputForm"></tr>
         <tr id="reasonForm"></tr>

      </table>
      <div id="btnDiv" class="float_right"></div>
      <div class="overflow_hidden">
         <c:if test="${loginUser.manager eq 'true' || isSelfReservation eq 'true'}">
            <c:if test="${reservation.state eq 'R' || reservation.state eq 'E'}">
               <fmt:formatDate value="${now}" pattern="yyyy.MM.dd kk:mm" var="today" />
               <fmt:formatDate value="${reservation.startDate}" pattern="yyyy.MM.dd kk:mm" var="startDate" />
               <fmt:formatDate value="${reservation.actualEndDate}" pattern="yyyy.MM.dd kk:mm" var="actualEndDate" />

               <c:choose>
                  <c:when test="${today >= startDate  &&  today < actualEndDate}">
                     <div id="processingDiv"  class="float_right">
                        <c:if test="${reservation.validateApplicant eq null || reservation.validateApplicant eq ''}">
                           <input type="button" id="exitReservation" value="조기종료" class="background_color"/>
                           <c:if test="${loginUser.manager eq 'false' && extendIspossible eq 'true'}">
                              <input type="button" id="extendReservation" value="연장신청" class="background_color" />
                           </c:if>
                        </c:if>
                     </div>
                  </c:when>
                  <c:otherwise>
                     <div id="reservationDiv" class="float_right">
                        <input type="button" id="cancelReservation" value="예약취소" class="background_color" />
                        <input  type="button" id="updateReservation" value="예약수정" class="background_color" />
                     </div>
                  </c:otherwise>
               </c:choose>
            </c:if>

            <c:if test="${reservation.state eq 'F'}">
               <div id="exitDiv" class="float_right">
                  <c:if test="${loginUser.manager eq 'true'}">
                     <input type="button" id="exitCheckReservation" value="종료확인" class="background_color" />
                  </c:if>
               </div>
            </c:if>
         </c:if>
      </div>
      <input type="hidden" size="50" name="oldUrl" value="${oldUrl}" />
      <input type="hidden" size="50" name="meetingRoomId" value="${reservation.meetingRoomId}" />
      <input type="hidden" size="50" name="reservationId" value="${reservation.reservationId}" />
   </form>
</section>
</body>
</html>