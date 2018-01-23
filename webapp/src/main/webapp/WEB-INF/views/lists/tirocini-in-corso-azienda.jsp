<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<spring:message code="domandaTirocinio.nomeProgetto.label" var="nomeProgettoLabel"/>
<spring:message code="domandaTirocinio.descrizioneProgetto.label" var="descrizioneProgettoLabel"/>

<spring:message var="nomeLabel" code="label.studenti.nomeCognome" />
<spring:message var="periodoTirocinioLabel" code="label.domandeTirocinio.periodoTirocinio" />
<spring:message var="emailLabel" code="registrazioneForm.email.label" />
<spring:message var="dataDiNascitaLabel" code="richiestaIscrizioneForm.dataDiNascita.label" />
<spring:message var="sessoLabel" code="registrazioneForm.sesso.label" />
<spring:message var="sessoMaschileLabel" code="registrazioneForm.sesso.maschile" />
<spring:message var="sessoFemminileLabel" code="registrazioneForm.sesso.femminile" />
<spring:message var="telefonoLabel" code="registrazioneForm.telefono.label" />
<spring:message var="commentoStudenteLabel" code="label.domandeTirocinio.commentoStudente" />

<c:forEach items="${tirociniInCorso}" var="current" varStatus="loop">
  <c:set var="idModalRifiuta" value="domandaTirocinio-modal-rifiuta-${loop.index}" />
  <c:set var="idModalAccetta" value="domandaTirocinio-modal-accetta-${loop.index}" />
    <ul id="idCollapsible" class="collapsible">
      <li>
        <div class="collapsible-header">
          <div class="col s8 valign-wrapper">
            <i class="material-icons">work</i>
            <c:out value="${current.studente.nome}"/> 
            <c:out value="${current.studente.cognome}"/> - 
            <c:out value="${current.progettoFormativo.nome}" />
          </div>
          <div class="col s4 right-align">
           <span class="right-align"><tags:localDateTime date="${current.data}"/></span>
          </div>
        </div>
      
        <div class="collapsible-body">
          <div class="row">
          
            <div class="col s12">
              <div class="row valign-wrapper" >
                <div class="col s1">
                  <a class="tooltipped tooltipped-icon" 
                     data-position="right"
                     data-delay="50"
                     data-tooltip="${nomeLabel}">
                     <i class ="small material-icons">face</i>
                  </a>      
                </div>
                <div class="col s11">
                  <c:out value="${current.studente.nome}" />  
                  <c:out value="${current.studente.cognome}" />
                </div>
              </div>
            </div>
          
          
            <div class="col s12">
              <div class="row valign-wrapper" >
                <div class="col s1">
                  <a class="tooltipped tooltipped-icon" 
                     data-position="right"
                     data-delay="50"
                     data-tooltip="${dataDiNascitaLabel}">
                     <i class ="small material-icons">cake</i>
                  </a>      
                </div>
                <div class="col s11">
                  <tags:localDate date="${current.studente.dataDiNascita}"/>
                </div>
              </div>
            </div>
            
            
            <div class="col s12">
              <div class="row valign-wrapper" >
                <div class="col s1">
                  <a class="tooltipped tooltipped-icon" 
                     data-position="right"
                     data-delay="50"
                     data-tooltip="${sessoLabel}">
                     <i class ="small material-icons">wc</i>
                  </a>      
                </div>
                <div class="col s11">
                  <c:choose>
                    <c:when test="${current.studente.sesso == 'M'}">
                      <c:out value="${sessoMaschileLabel}" />
                    </c:when>
                    <c:when test="${current.studente.sesso == 'F'}">
                      <c:out value="${sessoFemminileLabel}" />
                    </c:when>
                  </c:choose>
                </div>
              </div>
            </div>
            
            
            <div class="col s12">
            <div class="row valign-wrapper">
              <div class="col s1">
                <a class="tooltipped tooltipped-icon"
                   data-position="right"
                   data-delay="50"
                   data-tooltip="<c:out value="${emailLabel}"/>">
                   <i class="small material-icons">email</i>
                </a>
              </div>
              <div class="col s11">
                <c:out value="${current.studente.email}" />
              </div>
            </div>
          </div>
          
          
          <div class="col s12">
            <div class="row valign-wrapper">
              <div class="col s1">
                <a class="tooltipped tooltipped-icon"
                   data-position="right"
                   data-delay="50"
                   data-tooltip="<c:out value="${telefonoLabel}"/>">
                   <i class="small material-icons">phone</i>
                </a>
              </div>
              <div class="col s11">
                <c:out value="${current.studente.telefono}" />
              </div>
            </div>
          </div>
          
          
            <div class="col s12">
              <div class="row valign-wrapper" >
                <div class="col s1">
                  <a class="tooltipped tooltipped-icon" 
                     data-position="right"
                     data-delay="50"
                     data-tooltip="${nomeProgettoLabel}">
                     <i class ="small material-icons">business_center</i>
                  </a>      
                </div>
                <div class="col s11">
                  <c:out value="${current.progettoFormativo.nome}" />
                </div>
              </div>
            </div>
            
            
            <div class="col s12">
              <div class="row valign-wrapper" >
                <div class="col s1">
                  <a class="tooltipped tooltipped-icon" 
                     data-position="right"
                     data-delay="50"
                     data-tooltip="${periodoTirocinioLabel}">
                    <i class ="small material-icons">event</i>
                  </a>      
                </div>
                <div class="col s11">
                  <tags:localDate date="${current.inizioTirocinio}"/> - 
                  <tags:localDate date="${current.fineTirocinio}"/>
                </div>
              </div>
            </div>
            
            
            <div class="col s12">
              <div class="row valign-wrapper">
                <div class="col s1">
                <a class="tooltipped tooltipped-icon" 
                     data-position="right"
                     data-delay="50"
                     data-tooltip="${commentoStudenteLabel}">
                     <i class="small material-icons">sms</i>
                  </a>
                </div>
                <div class="col s11">
                  <c:out value="${current.commentoStudente}"/>
                </div>
              </div>
            </div>
                   
          </div>
        </div>
      </li>
    </ul>
</c:forEach>

<!-- Script per l'inizializzazione e la validazione dei form -->
<script type="text/javascript"
        src="<c:url value="/resources/js/domandeTirocinio.js" />" ></script>