<?php

namespace App\Http\Controllers\API;

use Exception;
use Validator;
use App\Models\Product;
use App\Models\Categorie;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Cart;

/**
 * Add Master data.
 * This is to manage category and product masters
 *
 * @author E Hariswar Reddy <eharishwarreddy666@gmail.com>
 */
class MasterController extends Controller
{

	/**
     * Create category master.
     *
     * @param Request $request
     */
	public function createCategory(Request $request) {
		try {

            /** Request Validation **/
            $validator = Validator::make($request->all(), [
                'category' => 'required|string|max:255|unique:categories'
            ]);

            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }else{

                $category = Categorie::create([
                        'category' => $request->category,
                ]);

                return response()->json(['success' => 'success'], 200);
            }

		} catch (Exception $e) {
			return response()->json(['error' => 'Sorry! Server Error'], 500);
		}
	}

    /**
     * Get Category List.
     *
     * @param Request $request
     *
     * @return App\Models\Categorie
     */
	public function getCategory(Request $request) {
		$categorie = Categorie::select('category','id')->get();
		return response()->json(['categorie' => $categorie], 200);
	}
	/**
     * Delete Category.
     *
     * @param int $id
     */
	public function deleteCategory($id) {

		$products = Product::where('category_id',$id)->count();

        if($products > 0){
			return response()->json(['error' => "Sorry! You Can't Delete categorie"], 500);

        }else{
            Categorie::where('id', $id)->delete();
            $categorie = Categorie::get();
            return response()->json(['categorie' => $categorie], 200);
        }

	}

	/**
     * Create product master.
     *
     * @param Request $request
     */
	public function createProduct(Request $request) {
		try {

            /** Request Validation **/
            $validator = Validator::make($request->all(), [
                'avatar' => 'required|string|max:255',
				'category_id' => 'required|numeric',
				'name' => 'required|string|max:255',
				'price' => 'required|numeric',
				'description' => 'required|max:255',
            ]);

            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }else{

                $product = Product::create([
                    'avatar' => $request->avatar,
                    'category_id' =>$request->category_id,
                    'name' => $request->name,
                    'price' => $request->price,
                    'description' => $request->description,
                ]);
                return response()->json(['success' => 'success'], 200);

            }

		} catch (Exception $e) {
			return response()->json(['error' => 'Sorry! Server Error'], 500);
		}
	}

	/**
     * Get Product List.
     *
     * @param Request $request
     *
     * @return App\Models\Product
     */
	public function getProducts(Request $request) {
		$products = Product::get();
		return response()->json(['products' => $products], 200);
	}

    	/**
     * Get Product List By Category.
     *
     * @param Request $request
     *
     * @return App\Models\Product
     */
	public function getProductsByCategory($id) {
		$products = Product::where('category_id',$id)->get();
		return response()->json(['products' => $products], 200);
	}

	/**
     * Get Single Product details.
     *
     * @param int $id
     *
     * @return App\Models\Product
     */
	public function getProductDetails($id = null) {
		$product = Product::join('categories', 'categories.id', 'products.category_id')
		->select('products.*', 'categories.category')->where('products.id', $id)->first();
		return response()->json(['product' => $product], 200);
	}

	/**
     * Delete Product
     *
     * @param int $id
     */
	public function deleteProduct($id) {

        $cart = Cart::where('product_id',$id)->count();

        if($cart > 0){
			return response()->json(['error' => "Sorry! You Can't Delete product"], 500);

        }else{
            Product::where('id', $id)->delete();
		    $products = Product::get();
            return response()->json(['products' => $products], 200);
        }
	}
}
