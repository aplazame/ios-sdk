//
//  APZMerchant.swift
//  Aplazame-sdk
//
//  Created by Andres Brun on 14/05/16.
//  Copyright © 2016 Andres Brun Moreno. All rights reserved.
//

import Foundation

struct APZMerchant {
    /**
     url that the JS client sent to confirming the order.
     */
    let confirmationUrl: String
    /**
     url that the customer is sent to if there is an error in the checkout.
     */
    let cancelUrl: String
    /**
     url that the customer is sent to after confirming their order.
     */
    let successUrl: String
    /**
     url that the customer is sent to after order is pending of confirmation.
     */
    let pendingUrl: String
    /**
     url that the customer is sent in case the credit has been denied.
     */
    let koURL: String
    /**
     url that the customer is sent to if the customer chooses to back to the eccommerce, by default is /.
     */
    let checkoutUrl: String
    /**
     (Sólo aplica si la API de confirmación está configurada) Establece el tiempo máximo, en minutos, del que dispone el usuario para completar el proceso de checkout. (por omisión 2880; mín. 1; máx. 2880 )
     */
    let timeoutCheckout: TimeInterval = 2880
    /**
     (Sólo aplica si la API de confirmación está configurada) Indica si el resultado de la solicitud de crédito aprobada por Aplazame debe completarse informando al usuario en el proceso de checkout
     */
    let confirmOnCheckout: Bool = true    
}

extension APZMerchant {
    static func create() -> APZMerchant {
        return APZMerchant(confirmationUrl: "/confirmation",
                        cancelUrl: "/cancel",
                        successUrl: "/success",
                        pendingUrl: "/pending",
                        koURL: "/ko",
                        checkoutUrl: "/checkout")
    }
}

extension APZMerchant {
    var record: APIRecordType {
        var record = APIRecordType()
        record["confirmation_url"] = confirmationUrl
        record["cancel_url"] = cancelUrl
        record["success_url"] = successUrl
        record["checkout_url"] = checkoutUrl
        record["checkout_url"] = checkoutUrl
        record["pending_url"] = pendingUrl
        record["ko_url"] = koURL
        record["timeout_checkout"] = timeoutCheckout
        record["confirm_on_checkout"] = confirmOnCheckout
        return record
    }
}
