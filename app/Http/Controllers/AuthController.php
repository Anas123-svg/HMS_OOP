<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function register(Request $r)
    {

        $rules = [
            'name' => 'required|string',
            'email' => 'required|string|unique:users',
            'password' => 'required|string|min:6',
            'designation' => 'required|string'
        ];
    

        $validator = Validator::make($r->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }
        try {
            $user = User::create([
                'name' => $r->name,
                'email' => $r->email,
                'password' => Hash::make($r->password),
                'designation' => $r->designation,
            ]);
    
            return response()->json(['message' => 'User created successfully', 'user' => $user], 201);
        } catch (\Exception $e) {
            echo $e->getMessage();
            return response()->json(['error' => 'User registration failed', 'message' => $e->getMessage()], 500);
        }
    }
    
    
    public function login(Request $request)
    {
        $rules = [
            'email' => 'required|string',
            'password' => 'required|string',
            'designation' => 'required|string',
        ];
        $validator = Validator::make($request->all(), $rules);
    
        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()->first()], 400);
        }
    
        $user = User::where('email', $request->email)->first();
    
        if ($user && Hash::check($request->password, $user->password)) {
            if ($request->designation == 'Doctor' && $user->designation == 'Doctor') {
                $doctorName = $user->name;
                $response = ['user' => ['name' => $doctorName]];
                return response()->json($response, 200);
            } elseif ($request->designation == 'Reception' && $user->designation == 'Reception') {

                $doctorName = $user->name;
                $response = ['user' => ['name' => $doctorName]]; 
                return response()->json($response, 200);
            } else {
                return response()->json(['message' => 'Unauthorized'], 401);
            }
        } else {
            return response()->json(['message' => 'Unauthorized'], 401);
        }
    }
    
    public function getDoctors()
    {
        try {

            $doctors = User::where('designation', 'Doctor')->get();
            return response()->json($doctors, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to retrieve doctors', 'message' => $e->getMessage()], 500);
        }
    }
    
    
}

