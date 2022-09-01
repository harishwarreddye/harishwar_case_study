<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Cart;
use Exception;
use Session;
use Validator;

/**
 * Manage Cart Here.
 * This is to manage cart functionality
 *
 * @author E Hariswar Reddy <eharishwarreddy666@gmail.com>
 */
class CartController extends Controller
{
	/**
     * Add Item to Cart.
     *
     * @param Request $request
     *
     * @return App\Models\Cart
     */
	public function addToCart(Request $request) {

        try {

            /** Request Validation **/
            $validator = Validator::make($request->all(), [
                'product_id' => 'required|numeric',
				'qty' => 'required|numeric',
            ]);
            $sessionId = Session::getId();
            $request->request->add(['session_id' =>$sessionId]); //add request

            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }else{

                $userID = Auth('sanctum')->user() ? Auth('sanctum')->user()->id : null;
                if($userID) {
                    /** If user Logged in, Update the quantity for already added product in cart. */
                    $sessionId = null;
                    $cart = Cart::where('user_id', $userID)
                        ->where('product_id', $request->product_id)
                        ->update([ 'qty' => $request->qty,
                            'session_id' => null ]);
                } else {
                    /** If guest, Update the quantity for already added product in cart. */
                    $sessionId = $request->session_id;
                    $cart = Cart::where('session_id', $request->session_id)
                        ->where('product_id', $request->product_id)
                        ->update(['qty' => $request->qty]);
                }

                if(!$cart) { /** If not already added product. Create New product in cart */
                    $cart = Cart::create([
                        'product_id' => $request->product_id,
                        'session_id' => $sessionId,
                        'qty' => $request->qty,
                        'user_id' => $userID,
                    ]);
                }
                // dd($cart);
                /** return updated cart */
                $data = $this->getCartItems($request);
                return response()->json(['data' => $data], 200);
            }

		} catch (Exception $e) {
			return response()->json(['error' => 'Sorry! Server Error'], 500);
		}
	}

	/**
     * Update Item in Cart.
     *
     * @param Request $request, int $id
     *
     * @return App\Models\Cart
     */
	public function updateCart(Request $request, $id) {
		/** update product quantity in the cart */
		$validatedData = $request->validate([
			'qty' => 'required|numeric',
		]);
        $sessionId = Session::getId();
        $request->request->add(['session_id' =>$sessionId]); //add request

		$userID = Auth('sanctum')->user() ? Auth('sanctum')->user()->id : null;
		if($userID) { /** auth user */
			Cart::where('id', $id)->where('user_id', $userID)
			->update([ 'qty' => $validatedData['qty']]);
		} else { /** guest */
			Cart::where('id', $id)->where('session_id', $validatedData['session_id'])
			->update([ 'qty' => $validatedData['qty']]);
		}

		$data = $this->getCartItems($request);
		return response()->json(['data' => $data], 200);
	}

	/**
     * Delete Item from Cart.
     *
     * @param Request $request, int $id
     *
     * @return App\Models\Cart
     */
	public function deleteCart(Request $request, $id) {


        $sessionId = Session::getId();
        $request->request->add(['session_id' =>$sessionId]); //add request

		/** remove cart item */
		$userID = Auth('sanctum')->user() ? Auth('sanctum')->user()->id : null;
		if($userID) { /** auth user */
			Cart::where('id', $id)->where('user_id', $userID)->delete();
		} else { /** guest */
			Cart::where('id', $id)->where('session_id', $request->session_id)->delete();
		}

		$data = $this->getCartItems($request);
		return response()->json(['data' => $data], 200);
	}

	/**
     * Get cart Items.
     *
     * @param Request $request
     *
     * @return App\Models\Cart
     */
	public function getCart(Request $request) {

        $sessionId = Session::getId();
        $request->request->add(['session_id' =>$sessionId]); //add request
		/** get cart details */
		$data = $this->getCartItems($request);
		return response()->json(['data' => $data], 200);
	}

	/**
	*Common function to get the cart Items based on user or guest
	*/
	public function getCartItems(Request $request) {
		$userID = Auth('sanctum')->user() ? Auth('sanctum')->user()->id : null;

		if($userID) { /** auth user */
			$productIdInSession = Cart::where('session_id', $request->session_id)->pluck('product_id')->toArray();
            /** check wthether logged in user having cart as guest */
			$productIdInCart = Cart::whereIn('product_id', $productIdInSession)->where('user_id', $userID)->delete();
            /** check whether same product is there in user cart and guest cart,If so delete user cart */
			Cart::where('session_id', $request->session_id)
				->update([ 'session_id' => null, 'user_id' => $userID ]);
                /** update guest cart to logged in user */
			$cart = Cart::where('user_id', $userID)->get();
		} else { /** guest */
			$cart = Cart::where('session_id', $request->session_id)->get();
            /** get guest cart  with session_id*/
		}

		return $cart;
	}
}
