<!--#include file=OpenDbConn.asp-->

<%
call OpenDbConn()
dim RSBooks
dim BookId
dim BookName
dim CategoryId
dim AuthorId
dim PublisherId
dim LanguageId

BookName = Request.Form("FormBookName")
CategoryId = cint(Request.Form("FormCategoryId"))
AuthorId = cint(Request.Form("FormAuthorId"))
PublisherId = cint(Request.Form("FormPublisherId"))
LanguageId = cint(Request.Form("FormLanguageId"))

Dim QryCondition
QryCondition = " WHERE(1 > 0) "


if BookName <> "" then 
    QryCondition = QryCondition & " AND (BookName like '%" & BookName & "%') "
end if

if CategoryId > 0 then 
    QryCondition = QryCondition & " AND (CategoryId = " & CategoryId & ") "
end if

if AuthorId > 0 then 
    QryCondition = QryCondition & " AND (AuthorId = " & AuthorId & ") "
end if

if PublisherId > 0 then 
    QryCondition = QryCondition & " AND (PublisherId = " & PublisherId & ") "
end if

if LanguageId > 0 then 
    QryCondition = QryCondition & " AND (LanguageId = " & LanguageId & ") "
end if

Set RSBooks = Server.CreateObject("ADODB.RecordSet")
RSBooks.Open "SELECT * FROM View_BooksDetailView " & QryCondition & " ORDER BY BookId DESC", conn

Dim RSCount
Set RSCount = Server.CreateObject("ADODB.RecordSet")
RSCount.Open "SELECT COUNT(BookId) AS TotalRecords FROM View_BooksDetailView " & QryCondition, conn

'Paging
        Dim RecNumber
        Dim PageNumber
        Dim SkipRec
        Dim LastPage
        dim RecPerPage
        RecPerPage = 20

        TotalRec = RSCount("TotalRecords")

        If Request.QueryString("QsPageNumber")="" then
            PageNumber = 1
            SkipRec=0
        else
            PageNumber = Cint(request.QueryString("QsPageNumber"))
            SkipRec = (PageNumber*RecPerPage)-RecPerPage
        End if

        If RSCount.EOF  or RSCount("TotalRecords")=1 then
            LastPage = 0
        else
            LastPage = Cstr((RSCount("TotalRecords")/RecPerPage))

            If InStr(LastPage,".") > 1 then
                LastPage = cint(LEFT(LastPage,InStr(LastPage,".")-1)) + 1
            end if
        End If
    'end

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <title>Books</title>
</head>

<style>
    form div {
        display: inline-block;
        margin: 0px 10px;
    }

    .total-records {
        color: white;
        font-size: 16px;
        font-weight: 600;
        display: flex;
        justify-content: center;
    }
</style>

<body style="background-color: #142e84;">
    <header>
        <!--#include file=Header.asp-->
    </header>

    <main>
        <section class="action">
            <div>
                <form class="search" action="BooksDetail.asp" METHOD="POST">
                    <div>
                        <input type="search" class="search-bar" placeholder="Search By Book Name" name="FormBookName">
                    </div>

                    <div>
                        <select name="FormCategoryId" class="search-bar" id="SelectCatg">
                            <option value="-1">Search By Category</option>
                            <%
                                    Dim RSCategory
                                    Set RSCategory = Server.CreateObject("ADODB.RecordSet")
                                    
                                    RSCategory.Open "SELECT * FROM ListCategory ORDER BY Category",Conn

                                    do while NOT RSCategory.EOF
                                %>
                            <option value="<% response.write(RSCategory("CategoryId")) %>">
                                <% response.write(RSCategory("Category")) %></option>
                            <%
                            RSCategory.MoveNext
                                    Loop
            
                                    RSCategory.Close
                                    Set RSCategory = Nothing
                                %>
                        </select>
                    </div>

                    <div>
                        <select name="FormAuthorId" class="search-bar" id="SelectAuthor">
                            <option value="-1">Search By Author</option>
                            <%
                                    Dim RSAuthor
                                    Set RSAuthor = Server.CreateObject("ADODB.RecordSet")
                                    
                                    RSAuthor.Open "SELECT * FROM ListAuthor ORDER BY AuthorName",Conn

                                    do while NOT RSAuthor.EOF
                                %>
                            <option value="<% response.write(RSAuthor("AuthorId")) %>">
                                <% response.write(RSAuthor("AuthorName")) %></option>
                            <%
                            RSAuthor.MoveNext
                                    Loop
            
                                    RSAuthor.Close
                                    Set RSAuthor = Nothing
                                %>
                        </select>
                    </div>

                    <div>
                        <select name="FormPublisherId" class="search-bar" id="SelectPublisher">
                            <option value="-1">Search By Publisher</option>
                            <%
                                    Dim RSPublisher
                                    Set RSPublisher = Server.CreateObject("ADODB.RecordSet")
                                    
                                    RSPublisher.Open "SELECT * FROM ListPublisher ORDER BY Publisher",Conn

                                    do while NOT RSPublisher.EOF
                                %>
                            <option value="<% response.write(RSPublisher("PublisherId")) %>">
                                <% response.write(RSPublisher("Publisher")) %></option>
                            <%
                            RSPublisher.MoveNext
                                    Loop
            
                                    RSPublisher.Close
                                    Set RSPublisher = Nothing
                                %>
                        </select>
                    </div>

                    <div>
                        <select name="FormLanguageId" class="search-bar" id="">
                            <option value="-1">Search By Language</option>
                            <%
                                    Dim RSLanguage
                                    Set RSLanguage = Server.CreateObject("ADODB.RecordSet")
                                    
                                    RSLanguage.Open "SELECT * FROM ListLanguage",Conn

                                    do while NOT RSLanguage.EOF
                                %>
                            <option value="<% response.write(RSLanguage("LanguageId")) %>">
                                <% response.write(RSLanguage("Language")) %></option>
                            <%
                            RSLanguage.MoveNext
                                    Loop
            
                                    RSLanguage.Close
                                    Set RSLanguage = Nothing
                                %>
                        </select>
                    </div>

                    <input type="submit" name="" id="" class="search-btn" value="Search">
                </form>
            </div>
            <div class="btn">
                <a href="AddNewBook.asp" class="add-new" title="Add New Book">Add New Book</a>
            </div>
        </section>

        <section class="grid">
            <span class="total-records">Total Records : <% response.write(RSCount("TotalRecords")) %></span>
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th style="width: 5%;">Book Id</th>
                        <th style="width: 25%;">Book Name</th>
                        <th style="width: 10%;">Category</th>
                        <th style="width: 15%;">Author</th>
                        <th style="width: 12%;">Publisher</th>
                        <th style="width: 8%;">Language</th>
                        <th style="width: 5%;">Book Pages</th>
                        <th style="width: 5%;">Quantity</th>
                        <th style="width: 8%;">Cabinet - Shelve</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                            Dim SkipCounter
                            
                            SkipCounter=1
                            RecNumber = 0
                        do while NOT RSBooks.EOF
                        if SkipCounter > SkipRec then
                        BookId = RSBooks("BookId")
                    %>
                    <tr>
                        <td><a
                                href="EditBookDetail.asp?QsId=<% response.write(RSBooks("BookId")) %>"><% response.write(RSBooks("BookId")) %></a>
                        </td>
                        <td><% response.write(RSBooks("BookName")) %></td>
                        <td><% response.write(RSBooks("Category")) %></td>
                        <td><% response.write(RSBooks("AuthorName")) %></td>
                        <td><% response.write(RSBooks("Publisher")) %></td>
                        <td><% response.write(RSBooks("Language")) %></td>
                        <td><% response.write(RSBooks("BookPages")) %></td>
                        <td><% response.write(RSBooks("Quantity")) %></td>
                        <td><% response.write(RSBooks("Cabinet") & " - " & RSBooks("Shelve")) %></td>
                    </tr>
                    <%
                                RecNumber = RecNumber + 1
                                            
                                End if
    
                                If RecPerPage = RecNumber then
                                    'PageNumber = PageNumber+1
                                    exit do
                                end if
                                
                                SkipCounter = SkipCounter+1
                        RSBooks.MoveNext
                        loop
                    %>
                </tbody>
            </table>
        </section>

        <div class="page-bar">
            <div class="page-nav">
                <% if LastPage = 0 or PageNumber <=1 then %>
                <a href="BooksDetail.asp?QsPageNumber=1" class="disabled">First</a>
                <% else %>
                <a href="BooksDetail.asp?QsPageNumber=1" class="">First</a>
                <% End if %>

                <% if PageNumber > 1 then %>
                <a href="BooksDetail.asp?QsPageNumber=<% response.write(PageNumber-1) %>" class="">Previous</a>
                <% else %>
                <a href="BooksDetail.asp?QsPageNumber=<% response.write(PageNumber-1) %>"
                    class="disable-btn">Previous</a>
                <% End if %>

                <% if LastPage > PageNumber then %>
                <a href="BooksDetail.asp?QsPageNumber=<% response.write(PageNumber+1) %>" class="">Next</a>
                <% else %>
                <a href="BooksDetail.asp?QsPageNumber=<% response.write(PageNumber+1) %>" class="disabled">Next</a>
                <% end if %>

                <% if LastPage > PageNumber then %>
                <a href="BooksDetail.asp?QsPageNumber=<% response.write(LastPage) %>" class="">Last</a>
                <% else %>
                <a href="BooksDetail.asp?QsPageNumber=<% response.write(LastPage) %>" class="disabled">Last</a>
                <% End if %>
            </div>
        </div>

    </main>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

</html>