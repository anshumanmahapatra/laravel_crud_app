<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <table border = '1'>
        <tr>
            <td>ID</td>
            <td>Email</td>
            <td>First Name</td>
            <td>Last Name</td>
            <td>Avatar</td>
        </tr>
        @foreach ($data as $item) 
        <tr>
            <td>{{ $item['id'] }}</td>
            <td>{{ $item['email'] }}</td>
            <td>{{ $item['first_name'] }}</td>
            <td>{{ $item['last_name'] }}</td>
            <td><img src={{$item['avatar']}} alt=""></td>
        </tr>
        @endforeach
    </table>
</body>
</html>