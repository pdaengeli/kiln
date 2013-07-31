<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:ex="http://apache.org/cocoon/exception/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Transform a Cocoon exception into HTML within a site
       template. The display is intended for end users, so make it
       easy to hide all technical details.

       Where a specific error is anticipated, it is anticipated that
       the ex:exception-report/ex:message element will have been
       replaced with a more verbose error message, potentially making
       use of HTML.
  -->

  <xsl:template match="ex:exception-report">
    <xsl:apply-templates select="ex:message" />
    <!-- To show/hide the full technical details, un/comment the
         following line. -->
    <xsl:call-template name="show-details" />
  </xsl:template>

  <xsl:template match="ex:exception-report/ex:message">
    <div class="message">
      <xsl:choose>
        <xsl:when test="*">
          <xsl:apply-templates />
        </xsl:when>
        <xsl:otherwise>
          <p>
            <xsl:apply-templates />
          </p>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template name="show-details">
    <div class="section-container tabs" data-section="tabs">
      <xsl:apply-templates mode="details" />
    </div>
  </xsl:template>

  <xsl:template match="ex:exception-report/ex:message" mode="details" />

  <xsl:template match="ex:cocoon-stacktrace" mode="details">
    <section>
      <p class="title" data-section-title="">
        <a href="#">Cocoon stacktrace</a>
      </p>
      <div class="content" data-section-content="">
        <xsl:apply-templates mode="details" />
      </div>
    </section>
  </xsl:template>

  <xsl:template match="ex:exception/ex:message" mode="details">
    <p><xsl:apply-templates mode="details" /></p>
  </xsl:template>

  <xsl:template match="ex:locations" mode="details">
    <table>
      <thead>
        <tr>
          <th scope="col">Line</th>
          <th scope="col">File</th>
          <th scope="col">Line #</th>
          <th scope="col">Column #</th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates mode="details" />
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="ex:location" mode="details">
    <tr>
      <td><xsl:value-of select="." /></td>
      <td><xsl:apply-templates mode="details" select="@uri" /></td>
      <td><xsl:value-of select="@line" /></td>
      <td><xsl:value-of select="@column" /></td>
    </tr>
  </xsl:template>

  <xsl:template match="ex:location/@uri" mode="details">
    <span title="{.}">
      <xsl:value-of select="substring-after(., 'webapps/ROOT/')" />
    </span>
  </xsl:template>

  <xsl:template match="ex:stacktrace" mode="details">
    <section>
      <p class="title" data-section-title="">
        <a href="#">Stacktrace</a>
      </p>
      <div class="content" data-section-content="">
        <pre style="font-size: 0.9em;">
          <xsl:apply-templates />
        </pre>
      </div>
    </section>
  </xsl:template>

  <xsl:template match="ex:full-stacktrace" mode="details">
    <section>
      <p class="title" data-section-title="">
        <a href="#">Full stacktrace</a>
      </p>
      <div class="content" data-section-content="">
        <pre style="font-size: 0.9em;">
          <xsl:apply-templates />
        </pre>
      </div>
    </section>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
