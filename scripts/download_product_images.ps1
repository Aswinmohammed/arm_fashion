$ErrorActionPreference = 'Stop'

$items = @(
  @{ Path = 'assets/images/products/men/structured-wool-overcoat.png'; Url = 'https://images.pexels.com/photos/14391921/pexels-photo-14391921.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/men/tailored-wool-blazer.png'; Url = 'https://images.pexels.com/photos/5367641/pexels-photo-5367641.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/men/oversized-cotton-shirt.png'; Url = 'https://images.pexels.com/photos/19189082/pexels-photo-19189082.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/men/nylon-shell-parka.png'; Url = 'https://images.pexels.com/photos/17391915/pexels-photo-17391915.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/men/executive-fit-trouser.png'; Url = 'https://images.pexels.com/photos/10252165/pexels-photo-10252165.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/men/tropical-casual-polo.png'; Url = 'https://images.pexels.com/photos/10769393/pexels-photo-10769393.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/men/batik-print-shirt.png'; Url = 'https://images.pexels.com/photos/29625971/pexels-photo-29625971.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/men/smart-fit-waistcoat.png'; Url = 'https://images.pexels.com/photos/6766246/pexels-photo-6766246.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },

  @{ Path = 'assets/images/products/women/atelier-jersey-tee.png'; Url = 'https://images.pexels.com/photos/19556879/pexels-photo-19556879.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/asymmetric-silk-blouse.png'; Url = 'https://images.pexels.com/photos/32711516/pexels-photo-32711516.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/ceylon-batik-maxi-dress.png'; Url = 'https://images.pexels.com/photos/36080765/pexels-photo-36080765.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/kurti-style-tunic.png'; Url = 'https://images.pexels.com/photos/31879662/pexels-photo-31879662.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/pleated-silk-trousers.png'; Url = 'https://images.pexels.com/photos/18734112/pexels-photo-18734112.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/cashmere-mock-neck.png'; Url = 'https://images.pexels.com/photos/7850255/pexels-photo-7850255.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/embroidered-lawn-top.png'; Url = 'https://images.pexels.com/photos/15227714/pexels-photo-15227714.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/office-pencil-skirt.png'; Url = 'https://images.pexels.com/photos/13801678/pexels-photo-13801678.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/festive-anarkali-dress.png'; Url = 'https://images.pexels.com/photos/34673508/pexels-photo-34673508.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/women/soft-wrap-cardigan.png'; Url = 'https://images.pexels.com/photos/35108820/pexels-photo-35108820.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },

  @{ Path = 'assets/images/products/shoes/square-toe-leather-boot.png'; Url = 'https://images.pexels.com/photos/31129832/pexels-photo-31129832.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/shoes/white-street-sneaker.png'; Url = 'https://images.pexels.com/photos/12739976/pexels-photo-12739976.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/shoes/ladies-block-heel.png'; Url = 'https://images.pexels.com/photos/30471927/pexels-photo-30471927.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/shoes/everyday-comfort-sandal.png'; Url = 'https://images.pexels.com/photos/36076377/pexels-photo-36076377.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/shoes/mens-loafer-classic.png'; Url = 'https://images.pexels.com/photos/8193568/pexels-photo-8193568.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/shoes/bridal-glitter-sandal.png'; Url = 'https://images.pexels.com/photos/35799161/pexels-photo-35799161.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/shoes/kids-sport-sneaker.png'; Url = 'https://images.pexels.com/photos/4987516/pexels-photo-4987516.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/shoes/woven-slip-on.png'; Url = 'https://images.pexels.com/photos/4161710/pexels-photo-4161710.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },

  @{ Path = 'assets/images/products/accessories/mini-tote-bag.png'; Url = 'https://images.pexels.com/photos/35685406/pexels-photo-35685406.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/accessories/ladies-sling-bag.png'; Url = 'https://images.pexels.com/photos/8945163/pexels-photo-8945163.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/accessories/occasion-clutch.png'; Url = 'https://images.pexels.com/photos/7256045/pexels-photo-7256045.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/accessories/ladies-fashion-belt.png'; Url = 'https://images.pexels.com/photos/27969727/pexels-photo-27969727.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/accessories/batik-scarf-wrap.png'; Url = 'https://images.pexels.com/photos/6630874/pexels-photo-6630874.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/accessories/statement-earring-set.png'; Url = 'https://images.pexels.com/photos/13442881/pexels-photo-13442881.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/accessories/travel-weekender-bag.png'; Url = 'https://images.pexels.com/photos/14037876/pexels-photo-14037876.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' },
  @{ Path = 'assets/images/products/accessories/minimal-watch-set.png'; Url = 'https://images.pexels.com/photos/9203637/pexels-photo-9203637.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260' }
)

foreach ($item in $items) {
  $directory = Split-Path -Parent $item.Path
  if (-not (Test-Path -LiteralPath $directory)) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
  }

  Write-Host "Downloading $($item.Path)"
  Invoke-WebRequest -Uri $item.Url -OutFile $item.Path
}

Write-Host "Downloaded $($items.Count) product images."
