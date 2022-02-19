<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function register(Request $request) {
        $request->validate([
            'name' => 'required',
            'email' => 'required|email',
            'password' => 'required|confirmed',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken(mt_rand(1000000000, 9999999999))->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token,
        ], 201);
    }

    public function logout() {
        auth()->user()->tokens()->delete();
        return [
            "Result" => "Successfully logged out"
        ];
    }

    public function login(Request $request) {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if(!$user) {
            return response([
                "Result" => "Email not Registered"
            ], 401);
        } else if (!Hash::check($request->password, $user->password)) {
            return response([
                "Result" => "Invalid Password"
            ], 401);
        } else {
            $token = $user->createToken(mt_rand(1000000000, 9999999999))->plainTextToken;

            return response([
                'user' => $user,
                'token' => $token,
            ], 200);
        }


    }


}
