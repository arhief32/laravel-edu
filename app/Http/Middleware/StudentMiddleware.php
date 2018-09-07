<?php

namespace App\Http\Middleware;

use Closure;

class StudentMiddleware
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
        if($request->header('userTypeID') != 3)
        {
            return response()->json([
                'responseCode' => '11',
                'responseDesc' => 'Tidak ada hak akses'
            ]);
        }

        return $next($request);
    }
}
