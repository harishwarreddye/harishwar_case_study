<?php

namespace App\Http\Controllers\API;

use Validator;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;


/**
 * User Authentication.
 * This is to manage users authentication
 *
 * @author E Harishwar Reddy <eharishwarreddy666@gmail.com>
 */
class AuthController extends Controller
{
	public function register(Request $request)
	{
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
	        'email' => 'required|string|email|max:255|unique:users',
	        'password' => 'required|string|min:8',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }else{

            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'admin' => $request->admin,
                'password' => Hash::make($request->password),
            ]);

            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'access_token' => $token,
                'token_type' => 'Bearer',
            ]);
        }
	}

    public function login(Request $request)
	{
		if (!Auth::attempt($request->only('email', 'password'))) {
			return response()->json([
				'message' => 'Invalid login details'
		    ], 401);
		}

		$user = User::where('email', $request['email'])->firstOrFail();

		$token = $user->createToken('auth_token')->plainTextToken;

		return response()->json([
           'access_token' => $token,
           'token_type' => 'Bearer',
		]);
	}
}
