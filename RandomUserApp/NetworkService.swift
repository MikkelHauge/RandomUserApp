//
//  NetworkService.swift
//  RandomUserApp
//
//  Created by tim on 01/03/2023.
//

import Foundation




class NetworkService {
	
	static func getData(from url: URL) async -> Data? {
		
		let session = URLSession.shared
		let (data, response) = try! await session.data(from: url)   // put this in a do/catch instead of doing the ! thing
		
		// make sure the HTTP response code is something non-errorous
		guard let httpUrlResponse = response as? HTTPURLResponse else { return nil }
		
		if httpUrlResponse.statusCode != 200 {
			fatalError("Got non-200 HTTP response - got \(httpUrlResponse.statusCode) instead")
		}
		
		return data
	

	}

	
}
