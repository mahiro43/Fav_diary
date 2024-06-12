module ApplicationHelper
  def show_meta_tags
    display_meta_tags
  end
    
  def default_meta_tags
    {
      site: '私の推し事活動',
      title: '私の推し事活動',
      reverse: true,
      separator: '|',
      description: '推し別に推し活の記録を書けるサービス',
      keywords: '推し,推し活,記録', 
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [                   
        { href: image_url('favicon.png') },
        { href: image_url('ogp.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: '私の推し事活動',
        title: '私の推し事活動',
        description: '推し別に推し活の記録を書けるサービス', 
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@anko_78_0722',
      }
    }
  end
end
