<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="/update-note" method = "POST">
        @csrf
        <input type="hidden" name = "id" value = "{{$data['id']}}">
        <input type="text" name = "title" value = "{{$data['title']}}" placeholder = "Enter Title"> <br> <br>
        <input type="text" name = "description" value = "{{$data['description']}}" placeholder = "Enter Description"> <br> <br>
        <button type = "submit"> Update Note</button>
    </form>
</body>
</html>