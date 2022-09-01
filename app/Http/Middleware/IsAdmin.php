<?php

namespace App\Http\Middleware;

use Auth;
use Closure;
use Response;

class IsAdmin
{
    /**
    * Handle an incoming request.
    *
    * @param  \Illuminate\Http\Request  $request
    * @param  \Closure  $next
    * @return mixed
    */
    public function handle($request, Closure $next)
    {

        if (Auth::user() &&  Auth::user()->admin == 1) {
            return $next($request);
        }

        return Response::json(array('error'=>'You are not an Admin'));
    }
}
