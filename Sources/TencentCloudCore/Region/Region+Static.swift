// Enumeration of the Tencent Cloud regions.
extension TencentCloud.Region {
    static var regular: [Self] = [
        .ap_bangkok,
        .ap_beijing,
        .ap_chengdu,
        .ap_chongqing,
        .ap_guangzhou,
        .ap_guangzhou_open,
        .ap_hongkong,
        .ap_numbai,
        .ap_nanjing,
        .ap_seoul,
        .ap_shanghai,
        .ap_singapore,
        .ap_tokyo,
        .eu_frankfurt,
        .eu_moscow,
        .na_ashburn,
        .na_siliconvalley,
        .na_toronto,
    ]

    static var financial: [Self] = [
        .ap_shanghai_fsi,
        .ap_shenzhen_fsi,
    ]

    static var mainland: [Self] = [
        .ap_beijing,
        .ap_chengdu,
        .ap_chongqing,
        .ap_guangzhou,
        .ap_guangzhou_open,
        .ap_nanjing,
        .ap_shanghai,
        .ap_shanghai_fsi,
        .ap_shenzhen_fsi,
    ]

    static var overseas: [Self] = [
        .ap_bangkok,
        .ap_hongkong,
        .ap_numbai,
        .ap_seoul,
        .ap_singapore,
        .ap_tokyo,
        .eu_frankfurt,
        .eu_moscow,
        .na_ashburn,
        .na_siliconvalley,
        .na_toronto,
    ]

    public static var ap_bangkok: Self { Self(rawValue: "ap-bangkok")! } // Thailand
    public static var ap_beijing: Self { Self(rawValue: "ap-beijing")! } // Beijing, China
    public static var ap_chengdu: Self { Self(rawValue: "ap-chengdu")! } // Sichuan, China
    public static var ap_chongqing: Self { Self(rawValue: "ap-chongqing")! } // Chongqing, China
    public static var ap_guangzhou: Self { Self(rawValue: "ap-guangzhou")! } // Guangdong, China
    public static var ap_guangzhou_open: Self { Self(rawValue: "ap-guangzhou-open")! } // Guangdong, China (Open)
    public static var ap_hongkong: Self { Self(rawValue: "ap-hongkong")! } // Hong Kong, China
    public static var ap_numbai: Self { Self(rawValue: "ap-numbai")! } // India
    public static var ap_nanjing: Self { Self(rawValue: "ap-nanjing")! } // Jiangsu, China
    public static var ap_seoul: Self { Self(rawValue: "ap-seoul")! } // South Korea
    public static var ap_shanghai: Self { Self(rawValue: "ap-shanghai")! } // Shanghai, China
    public static var ap_shanghai_fsi: Self { Self(rawValue: "ap-shanghai-fsi")! } // Shanghai, China (Financial)
    public static var ap_shenzhen_fsi: Self { Self(rawValue: "ap-shenzhen-fsi")! } // Guangdong, China (Financial)
    public static var ap_singapore: Self { Self(rawValue: "ap-singapore")! } // Singapore
    public static var ap_tokyo: Self { Self(rawValue: "ap-tokyo")! } // Japan

    public static var eu_frankfurt: Self { Self(rawValue: "eu-frankfurt")! } // German
    public static var eu_moscow: Self { Self(rawValue: "eu-moscow")! } // Russia
    public static var na_ashburn: Self { Self(rawValue: "na-ashburn")! } // Virginia, US
    public static var na_siliconvalley: Self { Self(rawValue: "na-siliconvalley")! } // California, US
    public static var na_toronto: Self { Self(rawValue: "na-toronto")! } // Canada
}
